//
//  AddWishCell.swift
//  vaolkhovskaiaPW2
//
//  Created by Вилина Ольховская on 12.03.2025.
//

import UIKit

final class AddWishCell: UITableViewCell {
    // MARK: - Enum
    private enum Constants {
        // Layout
        static let horizontalOffset: CGFloat = 16
        static let verticalOffset: CGFloat = 8
        static let textViewButtonSpacing: CGFloat = 8
        
        // Button
        static let buttonWidth: CGFloat = 60
        static let buttonHeight: CGFloat = 40
        
        // Text View
        static let textFontSize: CGFloat = 14
        static let cornerRadius: CGFloat = 8
        static let borderAlpha: CGFloat = 0.2
        static let borderWidth: CGFloat = 1.0
        static let textContainerInset: CGFloat = 8
    }
    
    // MARK: - Properties
    static let reuseId: String = "AddWishCell"
    var addWish: ((String) -> Void)?
    let textView: UITextView = UITextView()
    let addButton: UIButton = UIButton()


    // MARK: - Lifecycle methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func configureUI() {
        selectionStyle = .none
        contentView.addSubview(addButton)
        configureTextView()
        configureAddButton()
    }
    
    private func configureTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textView)
        
        textView.isScrollEnabled = false
        textView.layer.borderColor = UIColor.lightGray.withAlphaComponent(Constants.borderAlpha).cgColor
        textView.layer.borderWidth = Constants.borderWidth
        textView.font = .systemFont(ofSize: Constants.textFontSize)
        textView.layer.cornerRadius = Constants.cornerRadius
        textView.textContainerInset = UIEdgeInsets(top: Constants.textContainerInset,left: Constants.textContainerInset,bottom: Constants.textContainerInset,right: Constants.textContainerInset)
        
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalOffset), textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalOffset), textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.verticalOffset), textView.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -Constants.textViewButtonSpacing)
        ])
    }
    
    private func configureAddButton() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add", for: .normal)
        
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = Constants.cornerRadius
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalOffset),
            addButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            addButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
        ])
    }
    
    @objc 
    private func addButtonPressed() {
        guard let text = textView.text, !text.isEmpty else { return }
        addWish?(text)
        textView.text = nil
        textView.resignFirstResponder()
    }
}
