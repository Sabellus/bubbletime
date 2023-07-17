//
//  MainCoordinator.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import Foundation

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    var finishFlow: (() -> Void)?
  
    private let factory: MainModuleFactory
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
  
    init(router: Router, factory: MainModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.factory = factory
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    override func start() {
        showStart()
    }
    private func showStart() {
        let output = factory.makeMainScreen()
        self.router.setRootModule(output, hideBar: false, isRoot: true)
    }
}
