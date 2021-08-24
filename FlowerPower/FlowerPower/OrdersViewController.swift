//
//  ViewController.swift
//  FlowerPower
//
//  Created by Calin Jula on 24.08.2021.
//

import UIKit

class OrdersViewController: UIViewController {

    @IBOutlet weak var ordersTableView: UITableView!
    private let refreshControl = UIRefreshControl()
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
        title = "Orders"
    }
    
    @objc private func fetchData() {
        refreshControl.beginRefreshing()
        viewModel.fetchOrdersAndCustomers().ensure { [weak self] in
            self?.refreshControl.endRefreshing()
        }.done { [weak self] in
            self?.viewModel.error = nil
            self?.ordersTableView.reloadData()
        }.catch { [weak self] error in
            self?.viewModel.error = error
            self?.ordersTableView.reloadData()
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
