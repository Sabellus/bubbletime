//
//  ApplicationCoordinator.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
  
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router

    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    override func start() {
        runMainFlow()
    }
    private func runMainFlow() {
        let coordinator = coordinatorFactory.makeMainCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
          self?.start()
          self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
