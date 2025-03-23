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
        static let numberOfSections: Int = 2
        static let userDefaultsKey: String = "storedWishes"
        static let estimatedRowHeight: CGFloat = 44
    }
    
    // MARK: - Properties
    private var wishes: [String] = [] {
        didSet {
            saveWishes()
        }
    }
    private let defaults = UserDefaults.standard
    private let indicatorView = UIView()
    private let table = UITableView(frame: .zero)
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWishes()
        view.backgroundColor = .blue
        configureIndicatorView()
        configureTable()
    }
    
    // MARK: - Private methods
    private func saveWishes() {
            defaults.set(wishes, forKey: Constants.userDefaultsKey)
    }
    
    private func loadWishes() {
        guard let savedWishes = defaults.array(forKey: Constants.userDefaultsKey) as? [String] else {
            return
        }
        wishes = savedWishes
    }
    
    private func configureIndicatorView() {
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.backgroundColor = .white
        indicatorView.layer.cornerRadius = Constants.indicatorCornerRadius
        
        view.addSubview(indicatorView)
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.indicatorTopPadding),
            indicatorView.widthAnchor.constraint(equalToConstant: Constants.indicatorWidth),
            indicatorView.heightAnchor.constraint(equalToConstant: Constants.indicatorHeight)
        ])
    }
    
    private func configureTable() {
        table.estimatedRowHeight = Constants.estimatedRowHeight
        table.rowHeight = UITableView.automaticDimension
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemPurple
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        
        view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: indicatorView.bottomAnchor, constant: Constants.tableOffset),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tableOffset),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.tableOffset),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.tableOffset)
        ])
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : wishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            ) as! AddWishCell
            
            cell.addWish = { [weak self] newWish in
                guard let self = self else { return }
                
                self.wishes.append(newWish)
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            ) as! WrittenWishCell
            cell.configure(with: wishes[indexPath.row])
            return cell
            
        default:
            fatalError("Unexpected section")
        }
    }
}
