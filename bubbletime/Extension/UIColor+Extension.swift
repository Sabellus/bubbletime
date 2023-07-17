//
//  UIColor+Extension.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import Foundation
import UIKit

extension UIColor {
    struct Pallete {
        static let white = UIColor.color(light: .white, dark: .black)
        static let black = UIColor.color(light: .black, dark: .white)
        static let whiteWhite = UIColor.color(light: .white, dark: .white)
        static let blackBlack = UIColor.color(light: .black, dark: .black)
        static let greyDark = UIColor.color(light: .hex("C4C4C4"), dark: .hex("3A454E"))
    }
}
extension UIColor {
    static func color(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? dark : light
            }
        } else {
            return light
        }
    }
}
extension UIColor {
    static func hex(_ hexString: String) -> UIColor {
        var hexString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") { hexString.remove(at: hexString.startIndex) }

        var rgbValue:UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        return .init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
