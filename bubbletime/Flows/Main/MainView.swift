//
//  MainView.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import Foundation
protocol MainView:BaseView {
    var onTapPush: (() -> Void)? { get set }
}
