//
//  AppDelegate.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var rootController: UINavigationController {
        window = UIWindow()
        let nav = UINavigationController()
        window?.rootViewController = nav
        window?.backgroundColor = UIColor.Pallete.white
        window?.initTheme()
        window?.makeKeyAndVisible()
        return self.window!.rootViewController as! UINavigationController
    }
    
    private lazy var applicationCoordinator: Coordinator = self.makeCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        themeWindow.makeKey()
        applicationCoordinator.start()
        return true
    }
    private func makeCoordinator() -> Coordinator {
        return ApplicationCoordinator(
            router: RouterImp(rootController: self.rootController, window: window),
            coordinatorFactory: CoordinatorFactoryImp())
    }
}
let themeWindow = ThemeWindow()
final class ThemeWindow: UIWindow {
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if Theme.current == .system {
            Theme.system.setActive()
        }
    }
}
