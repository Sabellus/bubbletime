//
//  Presentable.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import Foundation
import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}
protocol Sitenable {
    func toSet() -> UITabBarController?
}
extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
}
extension UITabBarController: Sitenable {
    func toSet() -> UITabBarController? {
        return self
    }
}

