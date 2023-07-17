//
//  MainCoordinatorOutput.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import Foundation
protocol MainCoordinatorOutput: AnyObject {
    var finishFlow: (() -> Void)? { get set }
}
