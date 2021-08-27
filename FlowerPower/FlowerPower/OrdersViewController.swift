//
//  ViewController.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import UIKit
import Lottie

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var ordersTableView: UITableView!

    private let refreshControl = UIRefreshControl()
    private var loadingView: LoadingView?
    let viewModel = OrdersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizeText()
        addRefreshControl()
        fetchData()
    }
    
    private func addRefreshControl() {
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        ordersTableView.refreshControl = refreshControl
    }
    
    private func localizeText() {
        title = "orders".localized
    }
    
    @objc private func fetchData() {
        refreshControl.beginRefreshing()
        viewModel.fetchOrdersAndCustomers().ensure { [weak self] in
            self?.refreshControl.endRefreshing()
        }.done { [weak self] in
            self?.viewModel.error = nil
            self?.ordersTableView.reloadData()
        }.catch { [weak self] error in
            self?.handle(error: error)
        }
    }
    
    private func changeStatus(for order: Order, newStatus: OrderStatus) {
        if loadingView == nil {
            loadingView = LoadingView()
        }
        loadingView?.startLoading(onTopOf: view)
        viewModel.changeStatusWithRefresh(for: order, to: newStatus).ensure { [weak self] in
            self?.loadingView?.stopLoading()
        }.done { [weak self] in
            self?.ordersTableView.reloadData()
        }.catch { [weak self] error in
            self?.handle(error: error)
        }
    }
    
    private func handle(error: Error) {
        if let networkError = error as? NetworkingError {
            switch networkError {
                case .orderUpdateFailed:
                    let alert = UIAlertController(title: "error".localizedCapitalized, message: networkError.errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "dismiss".localizedCapitalized, style: .cancel, handler: nil))
                    present(alert, animated: true, completion: nil)
                default:
                    viewModel.error = error
                    ordersTableView.reloadData()
            }
        } else {
            viewModel.error = error
            ordersTableView.reloadData()
        }
    }
}

extension OrdersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfOrders
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.doesErrorExists {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ErrorTableViewCell.reuseIdentifier) as? ErrorTableViewCell,
                  let error = viewModel.error else {
                return UITableViewCell()
            }
            cell.configureMessage(for: error)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.reuseIdentifier) as? OrderTableViewCell,
                  let orderToDisplay = viewModel.getOrder(for: indexPath.row),
                  let customerToDisplay = viewModel.getCustomer(for: orderToDisplay) else {
                return UITableViewCell()
            }
            cell.configureCell(for: orderToDisplay, and: customerToDisplay)
            return cell
        }
    }
}

extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.doesErrorExists {
            fetchData()
        } else {
            guard let order = viewModel.getOrder(for: indexPath.row),
                  let customer = viewModel.getCustomer(for: order) else {
                return
            }
            let viewModelToSend = OrderDetailsViewModel(order: order, customer: customer)
            performSegue(withIdentifier: .goToOrderDetail, sender: viewModelToSend)
        }
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: {
            suggestedActions in
            let possibleChanges = self.viewModel.getChangeStatus(for: indexPath.row)
            let changeActions = possibleChanges.map { status in
                return UIAction(title: status.actionText, image: UIImage(systemName: status.systemImageName)) { action in
                    guard let orderToChange = self.viewModel.getOrder(for: indexPath.row) else { return }
                    self.changeStatus(for: orderToChange, newStatus: status)
                }
            }
            return UIMenu(title: "", children: changeActions)
        })
    }
}

extension OrdersViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case goToOrderDetail
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch segueIdentifier(identifier) {
            case .goToOrderDetail:
                return sender is OrderDetailsViewModel
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(segue.identifier) {
            case .goToOrderDetail:
                guard let detailsViewController = segue.destination as? OrderDetailViewController,
                      let detailsViewModel = sender as? OrderDetailsViewModel else {
                    return
                }
                detailsViewController.viewModel = detailsViewModel
        }
    }
}
