//
//  CoordinatorFactory.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import Foundation
protocol CoordinatorFactory {
    func makeMainCoordinator(router: Router) -> Coordinator & MainCoordinatorOutput
}
