//
//  WrittenWishCell.swift
//  vaolkhovskaiaPW2
//
//  Created by Вилина Ольховская on 11.01.2025.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    // MARK: - Enum
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
        static let zero: Int = 0
    }

    // MARK: - Fields
    static let reuseId: String = "WrittenWishCell"
    let wishLabel: UILabel = UILabel()
    private let wrap: UIView = UIView()

    // MARK: - Lifecycle methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func configure(with wish: Wish) {
        wishLabel.text = wish.text
    }

    // MARK: - Private method
    private func configureUI() {
        wrap.translatesAutoresizingMaskIntoConstraints = false
        wishLabel.translatesAutoresizingMaskIntoConstraints = false
        selectionStyle = .none
        backgroundColor = .clear

        addSubview(wrap)
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius

        NSLayoutConstraint.activate([
            wrap.topAnchor.constraint(equalTo: topAnchor, constant: Constants.wrapOffsetV),
            wrap.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.wrapOffsetV),
            wrap.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.wrapOffsetH),
            wrap.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.wrapOffsetH)
        ])

        wrap.addSubview(wishLabel)
        NSLayoutConstraint.activate([
            wishLabel.topAnchor.constraint(equalTo: wrap.topAnchor, constant: Constants.wishLabelOffset),
            wishLabel.bottomAnchor.constraint(equalTo: wrap.bottomAnchor, constant: -Constants.wishLabelOffset),
            wishLabel.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.wishLabelOffset),
            wishLabel.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -Constants.wishLabelOffset)
        ])
        wishLabel.numberOfLines = Constants.zero
        wishLabel.lineBreakMode = .byWordWrapping
    }
}
