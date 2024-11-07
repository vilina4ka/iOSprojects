//
//  UIColorExtension.swift
//  vaolkhovskaiaPW2
//
//  Created by Вилина Ольховская on 05.11.2024.
//

import UIKit

extension UIColor {
    convenience init?(hex: String) {
        // MARK: - Constants
        enum Constants {
            static let redMask: UInt64 = 0xFF0000
            static let greenMask: UInt64 = 0x00FF00
            static let blueMask: UInt64 = 0x0000FF
            static let colorDivisor: CGFloat = 255.0
            static let alpha: CGFloat = 1.0
        }
        
        // MARK: - Fields
        let rightHex = hex.replacingOccurrences(of: "#", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        var rgb: UInt64 = 0
        guard Scanner(string: rightHex).scanHexInt64(&rgb)
        else { return nil}

        let redColor = CGFloat((rgb & Constants.redMask) >> 16) / Constants.colorDivisor
        let greenColor = CGFloat((rgb & Constants.greenMask) >> 8) / Constants.colorDivisor
        let blueColor = CGFloat(rgb & Constants.blueMask) / Constants.colorDivisor
        
        // MARK: - Lifecycle methods
        self.init(red: redColor, green: greenColor, blue: blueColor, alpha: Constants.alpha)
    }
}

