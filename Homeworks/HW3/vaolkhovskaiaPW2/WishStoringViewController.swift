//
//  WishStoringViewController.swift
//  vaolkhovskaiaPW2
//
//  Created by Вилина Ольховская on 11.01.2025.
//

import UIKit

final class WishStoringViewController: UIViewController {
    
    // MARK: - Enum
    private enum Constants {
        static let indicatorCornerRadius: CGFloat = 2
        static let indicatorTopPadding: CGFloat = 10
        static let indicatorWidth: CGFloat = 80
        static let indicatorHeight: CGFloat = 4
    }
    
    // MARK: - Field
    let indicatorView : UIView = UIView()
    
    // MARK: - Lifecycle method
    override func viewDidLoad() {
        view.backgroundColor = .blue
        configureIndicatorView()
    }
    
    // MARK: - Private methods
    private func configureIndicatorView() {
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.backgroundColor = .white
        indicatorView.layer.cornerRadius = Constants.indicatorCornerRadius
        
        view.addSubview(indicatorView)
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.indicatorTopPadding),
            indicatorView.widthAnchor.constraint(equalToConstant: Constants.indicatorWidth),
            indicatorView.heightAnchor.constraint(equalToConstant: Constants.indicatorHeight)
        ])
    }
}
