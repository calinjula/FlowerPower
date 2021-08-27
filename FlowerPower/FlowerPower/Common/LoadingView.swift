//
//  LoadingView.swift
//  FlowerPower
//
//  Created by Calin Jula on 27.08.2021.
//

import UIKit
import Lottie

class LoadingView: UIView {
    
    private var animationView: AnimationView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLoadingView()
        backgroundColor = .white.withAlphaComponent(0.5)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addLoadingView()
    }
    
    private func addLoadingView() {
        let lottieAnimation = AnimationView(name: "loading-animation")
        lottieAnimation.contentMode = .scaleAspectFit
        lottieAnimation.loopMode = .autoReverse
        self.addSubview(lottieAnimation)
        
        lottieAnimation.translatesAutoresizingMaskIntoConstraints = false
        lottieAnimation.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lottieAnimation.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.animationView = lottieAnimation
    }
    
    func startLoading(onTopOf view: UIView) {
        self.frame = view.frame
        view.addSubview(self)
        animationView?.play()
    }
    
    func stopLoading() {
        animationView?.stop()
        self.removeFromSuperview()
    }
}
