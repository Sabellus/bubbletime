//
//  Router.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import UIKit
final class RouterImp: NSObject, Router {
    private weak var rootController: UINavigationController?
    private weak var window: UIWindow?
    private var initRootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    
    init(rootController: UINavigationController, window: UIWindow? = nil) {
        self.rootController = rootController
        self.initRootController = rootController
        self.window = window
        completions = [:]
    }
    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false, isRoot: false)
    }
    func setRootModule(_ module: Presentable?, hideBar: Bool, isRoot: Bool) {
        guard let controller = module?.toPresent() else { return }
        if isRoot {
            rootController = initRootController
            window?.rootViewController = self.rootController
        }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    func toPresent() -> UIViewController? {
        return rootController
    }
}
