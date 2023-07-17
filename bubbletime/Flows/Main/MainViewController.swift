//
//  MainViewController.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import Foundation
import UIKit

class MainViewController: UIViewController, MainView {
    var onStart: (() -> Void)?
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var timer: Timer?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Pallete.white
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    func setupViews() {
        [].forEach(view.addSubview)
    
        NSLayoutConstraint.activate([
            
        ])
        view.layoutIfNeeded()
    }
}
