//
//  CoordinatorFactoryImp.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import Foundation
final class CoordinatorFactoryImp: CoordinatorFactory {
    func makeMainCoordinator(router: Router) -> Coordinator & MainCoordinatorOutput {
        let coordinator = MainCoordinator(router: router, factory: ModuleFactoryImp(), coordinatorFactory: self)
        return coordinator
    }
}
