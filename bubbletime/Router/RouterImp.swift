//
//  RouterImp.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import UIKit

protocol Router: Presentable {
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool, isRoot: Bool)
}
