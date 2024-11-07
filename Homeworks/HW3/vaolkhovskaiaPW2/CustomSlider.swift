//
//  File.swift
//  vaolkhovskaiaPW2
//
//  Created by Вилина Ольховская on 05.11.2024.
//

import UIKit

final class CustomSlider: UIView {
    // MARK: - Constants
    private enum Constants {
        static let titleViewTopPadding: CGFloat = 10
        static let titleViewLeadingPadding: CGFloat = 20
        static let sliderLeadingPadding: CGFloat = 20
        static let sliderBottomPadding: CGFloat = -10
    }
    
    // MARK: - Fields
    var valueChanged: ((Double) -> Void)?
    var slider = UISlider()
    var titleView = UILabel()
    
    // MARK: - Lifecycle methods
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleViewLeadingPadding),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleViewTopPadding),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeadingPadding),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.sliderBottomPadding)
        ])
    }
    
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}

