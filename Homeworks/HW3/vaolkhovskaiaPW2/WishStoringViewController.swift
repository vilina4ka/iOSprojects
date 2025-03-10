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
        
        
        static let tableOffset: CGFloat = 20
        static let tableCornerRadius: CGFloat = 20
    }
    
    // MARK: - Field
    let indicatorView: UIView = UIView()
    let cell: UITableViewCell = UITableViewCell()
    let table: UITableView = UITableView(frame: .zero)
    
    // MARK: - Lifecycle method
    override func viewDidLoad() {
        view.backgroundColor = .blue
        configureIndicatorView()
        configureTable()
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
    private func configureTable() {
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: indicatorView.bottomAnchor, constant: Constants.tableOffset),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tableOffset),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.tableOffset),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.tableOffset)
        ])
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell
    }
}
