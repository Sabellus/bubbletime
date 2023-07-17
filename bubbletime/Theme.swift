//
//  Theme.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import Foundation
import UIKit

@propertyWrapper
struct Persist<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
extension UIWindow {
    func initTheme() {
        guard #available(iOS 13.0, *) else { return }
        overrideUserInterfaceStyle = Theme.current.userInterfaceStyle
    }
}
enum Theme: Int, CaseIterable {
    case system = 0
    case light
    case dark
}
extension Theme {
    @Persist(key: "app_theme", defaultValue: Theme.system.rawValue)
    private static var appTheme: Int
    
    func save() {
        Theme.appTheme = self.rawValue
    }
    static var current: Theme {
        Theme(rawValue: appTheme) ?? .system
    }
    @available(iOS 12.0, *)
    static var currentTheme: UIUserInterfaceStyle {
        return themeWindow.traitCollection.userInterfaceStyle
    }
}
extension Theme {
    @available(iOS 13.0, *)
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return themeWindow.traitCollection.userInterfaceStyle
        }
    }
    
    func setActive() {
        save()
        
        guard #available(iOS 13.0, *) else { return }
        
        UIApplication.shared.windows
            .filter { $0 != themeWindow }
            .forEach { $0.overrideUserInterfaceStyle = userInterfaceStyle }
    }
}
