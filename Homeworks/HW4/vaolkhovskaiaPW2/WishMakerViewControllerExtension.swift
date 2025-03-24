//
//  WishMakerViewControllerExtension.swift
//  vaolkhovskaiaPW2
//
//  Created by Вилина Ольховская on 07.11.2024.
//

import UIKit

extension WishMakerViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        view.backgroundColor = viewController.selectedColor
    }

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        view.backgroundColor = viewController.selectedColor
    }
}

