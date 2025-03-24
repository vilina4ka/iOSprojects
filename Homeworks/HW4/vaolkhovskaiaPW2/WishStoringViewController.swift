//
//  WishStoringViewController.swift
//  vaolkhovskaiaPW2
//
//  Created by Вилина Ольховская on 11.01.2025.
//

import UIKit
import CoreData

final class WishStoringViewController: UIViewController {
    // MARK: - Enum
    private enum Constants {
        static let indicatorCornerRadius: CGFloat = 2
        static let indicatorTopPadding: CGFloat = 10
        static let indicatorWidth: CGFloat = 80
        static let indicatorHeight: CGFloat = 4

        static let tableOffset: CGFloat = 20
        static let tableCornerRadius: CGFloat = 20
        static let estimatedRowHeight: CGFloat = 44
    }

    // MARK: - Properties
    private var fetchedResultsController: NSFetchedResultsController<Wish>!
    private let coreDataManager = CoreDataManager.shared
    private let indicatorView = UIView()
    private let table = UITableView(frame: .zero)

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        configureIndicatorView()
        configureTable()
        setupFetchedResultsController()
        configureLongPressGesture()
    }

    // MARK: - Private methods
    private func setupFetchedResultsController() {
        let fetchRequest = NSFetchRequest<Wish>(entityName: "Wish")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]

        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: coreDataManager.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
            table.reloadData()
        } catch {
            print("Fetch error: \(error.localizedDescription)")
        }
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
        table.delegate = self
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

    private func showEditAlert(for wish: Wish) {
        let alert = UIAlertController(title: "Edit Wish", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = wish.text
        }

        alert.addAction(UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard
                let self = self,
                let text = alert.textFields?.first?.text,
                !text.isEmpty
            else {
                return
            }
            wish.text = text
            self.coreDataManager.saveContext()
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    private func shareWish(_ text: String) {
        let activityVC = UIActivityViewController(
            activityItems: [text],
            applicationActivities: nil
        )
        present(activityVC, animated: true)
    }

    private func configureLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        table.addGestureRecognizer(longPress)
    }

    @objc
    private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: table)
            guard let indexPath = table.indexPathForRow(at: point) else { return }
            showEditMenu(for: indexPath)
        }
    }

    private func showEditMenu(for indexPath: IndexPath) {
        guard indexPath.row > 0, indexPath.row <= fetchedResultsController.fetchedObjects!.count else {
            return
        }

        let wish = fetchedResultsController.object(at: IndexPath(row: indexPath.row - 1, section: 0)) as Wish
        let alert = UIAlertController(title: "Edit Wish", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Edit", style: .default) { [weak self] _ in
            self?.showEditAlert(for: wish)
        })

        alert.addAction(UIAlertAction(title: "Share", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let wish = self.fetchedResultsController.object(at: IndexPath(row: indexPath.row - 1, section: 0)) as Wish
            self.shareWish(wish.text ?? "")
        })

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteWish(at: indexPath)
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    private func deleteWish(at indexPath: IndexPath) {
        guard indexPath.row > 0, indexPath.row <= fetchedResultsController.fetchedObjects!.count else {
            return
        }
        let wish = fetchedResultsController.object(at: IndexPath(row: indexPath.row - 1, section: 0)) as Wish
        coreDataManager.context.delete(wish)
        coreDataManager.saveContext()
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let sections = fetchedResultsController.sections?.count ?? 1
        return 1 
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         let wishesCount = fetchedResultsController.fetchedObjects?.count ?? 0
         let rows = 1 + wishesCount
         return rows
     }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            ) as! AddWishCell

            cell.addWish = { [weak self] newText in
                guard let self = self else { return }

                let context = CoreDataManager.shared.context
                let newWish = Wish(context: context)
                newWish.text = newText
                newWish.createdAt = Date()

                if context.hasChanges {
                    do {
                        try context.save()
                         DispatchQueue.main.async {
                             self.table.reloadData()
                         }
                    } catch {
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                }

            }
            return cell
        } else { // Wishes
            let cell = tableView.dequeueReusableCell(
              withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            ) as! WrittenWishCell
            let wish = fetchedResultsController.object(at: IndexPath(row: indexPath.row - 1, section: 0)) as Wish
            cell.configure(with: wish)
            return cell
        }
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete && indexPath.row > 0 {
            deleteWish(at: indexPath)
        }
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        guard indexPath.row > 0 else { return nil }

        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { [weak self] _, _, _ in
            self?.deleteWish(at: indexPath)
        }

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

// MARK: - UITableViewDelegate
extension WishStoringViewController: UITableViewDelegate {}

// MARK: - NSFetchedResultsControllerDelegate
extension WishStoringViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        table.reloadData()
    }
}
