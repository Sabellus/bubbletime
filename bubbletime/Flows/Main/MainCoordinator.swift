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
    private let pushFactory: PushManagerFactory
  
    init(router: Router, factory: MainModuleFactory, coordinatorFactory: CoordinatorFactory, pushFactory: PushManagerFactory) {
        self.factory = factory
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.pushFactory = pushFactory
    }
    override func start() {
        showStart()
    }
    private func showStart() {
        let output = factory.makeMainScreen()
        output.onTapPush = { [weak self] in
            self?.pushFactory.requestPushAuthorization(openSettings: false, completion: {
                self?.pushFactory.scheduleLocalNotification(title: Strings.reminder, body: Strings.passed, timeInterval: 10)
            })
        }
        self.router.setRootModule(output, hideBar: false, isRoot: true)
    }
}
