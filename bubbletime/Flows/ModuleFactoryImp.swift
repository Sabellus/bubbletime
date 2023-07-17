//
//  ModuleFactoryImp.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import Foundation
final class ModuleFactoryImp: MainModuleFactory {
    func makeMainScreen() -> MainView {
        let vc = MainViewController()
        return vc
    }
}
