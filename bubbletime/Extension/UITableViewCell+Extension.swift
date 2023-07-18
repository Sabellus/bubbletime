//
//  UITableView+Extension.swift
//  bubbletime
//
//  Created by  savelii on 18.07.23.
//

import Foundation
import UIKit

protocol CellConfigurer:AnyObject {
    static var reuseIdentifier: String {get}
}
extension CellConfigurer {
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}
extension UITableViewCell: CellConfigurer {}

