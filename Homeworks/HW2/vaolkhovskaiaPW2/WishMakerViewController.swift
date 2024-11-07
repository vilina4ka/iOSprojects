//
//  WishMakerViewController.swift
//  vaolkhovskaiaPW2
//
//  Created by Вилина Ольховская on 05.11.2024.
//

import UIKit

final class WishMakerViewController: UIViewController {
    // MARK: - Enums
    private enum Constants {
        // Font sizes
        static let titleFontSize: CGFloat = 32
        static let descriptionFontSize: CGFloat = 18
        
        // Colors
        static let titleTextColor: UIColor = .white
        static let buttonBackgroundColor: UIColor = .white
        
        // Color values
        static let alpha: CGFloat = 1.0
        static let minColorValue: Int = 0
        static let maxColorValue: Int = 1
        
        // Corner radius
        static let buttonCornerRadius: CGFloat = 5
        static let stackCornerRadius: CGFloat = 20
        
        // Spacings and paddings
        static let leadingPadding: CGFloat = 20
        static let topPadding: CGFloat = 30
        static let titleTopPadding: CGFloat = 30
        static let descriptionTopPadding: CGFloat = 20
        static let stackBottomPadding: CGFloat = -40
        static let buttonSpacing: CGFloat = 20
        static let textFieldWidthOffset: CGFloat = -150
        static let buttonHexWidthOffset: CGFloat = 250
        
        // Texts
        static let titleText = "WishMaker"
        static let descriptionText = """
        This app provides you the oportunity to fulfil your wishes!
        \n\n1. You can change the background color by 4 variants.
        """
        static let slidersButtonText = "color sliders"
        static let randomColorButtonText = "random color"
        static let hexTextFieldPlaceholder = "enter HEX code"
        static let applyHexButtonText = "apply"
        static let colorPickerButtonText = "color picker"
        
        // Slider ranges
        static let sliderMinValue: CGFloat = 0
        static let sliderMaxValue: CGFloat = 255
        
        // Slider float max
        static let sliderMax: Float = 255.0
    }
    
    // MARK: - Fields
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let textHex = UITextField()
    
    let buttonSliders = UIButton(type: .system)
    let buttonRandom = UIButton(type: .system)
    let buttonHex = UIButton(type: .system)
    let buttonPicker = UIButton(type: .system)
    
    let stack = UIStackView()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        view.backgroundColor = .systemPink
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        configureTitle()
        configureDescription()
        
        configureButtonSliders()
        configureSliders()
        configureButtonRandom()
        
        configureTextHex()
        
        configureButtonHex()
        configureButtonColorPicker()
    }
    
    @objc
    private func slidersVisibility() {
        stack.isHidden.toggle()
    }
    
    @objc
    private func setRandomColor() {
        view.backgroundColor = UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: Constants.alpha
        )
    }
    
    @objc
    private func applyHexColor() {
        guard let codeHex = textHex.text, !codeHex.isEmpty else { return }
        
        if let color = UIColor(hex: codeHex) {
            view.backgroundColor = color
        }
    }
    
    @objc private func openColorPicker() {
        if #available(iOS 14.0, *) {
            let colorPicker = UIColorPickerViewController()
            colorPicker.delegate = self
            colorPicker.supportsAlpha = true
            colorPicker.selectedColor = view.backgroundColor ?? .white
            present(colorPicker, animated: true, completion: nil)
        }
    }

    
    private func configureTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Constants.titleText
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.textColor = Constants.titleTextColor
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingPadding),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTopPadding)
        ])
    }
    
    private func configureDescription() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = Constants.descriptionText
        descriptionLabel.numberOfLines = 7
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.textColor = Constants.titleTextColor
        
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingPadding),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.descriptionTopPadding)
        ])
    }
    
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.isHidden.toggle()
        stack.layer.cornerRadius = Constants.stackCornerRadius
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: "Red", min: Constants.sliderMinValue, max: Constants.sliderMaxValue)
        let sliderBlue = CustomSlider(title: "Blue", min: Constants.sliderMinValue, max: Constants.sliderMaxValue)
        let sliderGreen = CustomSlider(title: "Green", min: Constants.sliderMinValue, max: Constants.sliderMaxValue)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingPadding),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.stackBottomPadding)
        ])
        
        sliderRed.valueChanged = { [weak self] value in self?.updateColor(sliderRed: sliderRed, sliderGreen: sliderGreen, sliderBlue: sliderBlue) }
        sliderGreen.valueChanged = { [weak self] value in self?.updateColor(sliderRed: sliderRed, sliderGreen: sliderGreen, sliderBlue: sliderBlue) }
        sliderBlue.valueChanged = { [weak self] value in self?.updateColor(sliderRed: sliderRed, sliderGreen: sliderGreen, sliderBlue: sliderBlue) }
    }
    
    private func configureButtonSliders() {
        buttonSliders.translatesAutoresizingMaskIntoConstraints = false
        buttonSliders.setTitle(Constants.slidersButtonText, for: .normal)
        buttonSliders.addTarget(self, action: #selector(slidersVisibility), for: .touchUpInside)
        buttonSliders.backgroundColor = Constants.buttonBackgroundColor
        buttonSliders.layer.cornerRadius = Constants.buttonCornerRadius
        
        view.addSubview(buttonSliders)
        NSLayoutConstraint.activate([
            buttonSliders.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonSliders.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingPadding),
            buttonSliders.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.buttonSpacing)
        ])
    }
    
    private func configureButtonRandom() {
        buttonRandom.translatesAutoresizingMaskIntoConstraints = false
        buttonRandom.setTitle(Constants.randomColorButtonText, for: .normal)
        buttonRandom.addTarget(self, action: #selector(setRandomColor), for: .touchUpInside)
        buttonRandom.backgroundColor = Constants.buttonBackgroundColor
        buttonRandom.layer.cornerRadius = Constants.buttonCornerRadius
        
        view.addSubview(buttonRandom)
        NSLayoutConstraint.activate([
            buttonRandom.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonRandom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingPadding),
            buttonRandom.topAnchor.constraint(equalTo: buttonSliders.bottomAnchor, constant: Constants.buttonSpacing)
        ])
    }
    
    private func configureTextHex() {
        textHex.translatesAutoresizingMaskIntoConstraints = false
        textHex.placeholder = Constants.hexTextFieldPlaceholder
        textHex.borderStyle = .roundedRect
        
        view.addSubview(textHex)
        NSLayoutConstraint.activate([
            textHex.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingPadding),
            textHex.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.textFieldWidthOffset),
            textHex.topAnchor.constraint(equalTo: buttonRandom.bottomAnchor, constant: Constants.buttonSpacing)
        ])
    }
    
    private func configureButtonHex() {
        buttonHex.translatesAutoresizingMaskIntoConstraints = false
        buttonHex.setTitle(Constants.applyHexButtonText, for: .normal)
        buttonHex.addTarget(self, action: #selector(applyHexColor), for: .touchUpInside)
        buttonHex.backgroundColor = Constants.buttonBackgroundColor
        buttonHex.layer.cornerRadius = Constants.buttonCornerRadius
        
        view.addSubview(buttonHex)
        NSLayoutConstraint.activate([
            buttonHex.leadingAnchor.constraint(equalTo: textHex.leadingAnchor, constant: Constants.buttonHexWidthOffset),
            buttonHex.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.leadingPadding),
            buttonHex.topAnchor.constraint(equalTo: buttonRandom.bottomAnchor, constant: Constants.buttonSpacing)
        ])
    }
    
    private func configureButtonColorPicker() {
        buttonPicker.translatesAutoresizingMaskIntoConstraints = false
        buttonPicker.setTitle(Constants.colorPickerButtonText, for: .normal)
        buttonPicker.addTarget(self, action: #selector(openColorPicker), for: .touchUpInside)
        buttonPicker.backgroundColor = Constants.buttonBackgroundColor
        buttonPicker.layer.cornerRadius = Constants.buttonCornerRadius
        
        view.addSubview(buttonPicker)
        NSLayoutConstraint.activate([
            buttonPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingPadding),
            buttonPicker.topAnchor.constraint(equalTo: buttonHex.bottomAnchor, constant: Constants.buttonSpacing)
        ])
    }
    
    private func updateColor(sliderRed: CustomSlider, sliderGreen: CustomSlider, sliderBlue: CustomSlider) {
        let redValue = CGFloat(sliderRed.slider.value / Constants.sliderMax)
        let greenValue = CGFloat(sliderGreen.slider.value / Constants.sliderMax)
        let blueValue = CGFloat(sliderBlue.slider.value / Constants.sliderMax)
        
        view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: Constants.alpha)
    }
}

