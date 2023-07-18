//
//  MainViewController.swift
//  bubbletime
//
//  Created by  savelii on 17.07.23.
//

import Foundation
import UIKit

class MainViewController: UIViewController, MainView {
    var onTapPush: (() -> Void)?
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var bubbleButton: BubbleButton = {
        let button = BubbleButton()
        button.setTitle(Strings.add, for: .normal)
        button.setTitleColor(UIColor.Pallete.white, for: .normal)
        button.sizeToFit()
        return button
    }()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    var times: [Date?] = []
    var rightItem: UIBarButtonItem?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Pallete.white
        self.title = Strings.nametitle
        tableView.dataSource = self
        tableView.delegate = self
        setupViews()
        setupNavigation()
        bubbleButton.frame = CGRect(x: 0, y: 0, width: bubbleButton.intrinsicContentSize.width, height: bubbleButton.intrinsicContentSize.width)
        bubbleButton.center = view.center
        bubbleButton.onTap = { [weak self] in
            let newDate = Date()
            self?.times.append(newDate)
            self?.tableView.reloadData()
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    func setupViews() {
        view.addSubview(containerView)
        [tableView, bubbleButton].forEach(containerView.addSubview)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
        ])
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    func setupNavigation() {        
        rightItem = UIBarButtonItem(image: UIImage.app(.bell), style: .plain, target: self, action: #selector(tapPush))
        rightItem?.tintColor = UIColor.Pallete.black
        self.navigationItem.rightBarButtonItem = rightItem
    }
    @objc func tapPush() {
        self.onTapPush?()
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        guard let date = times[indexPath.row] else { return cell }
        cell.textLabel?.text = nil
        cell.textLabel?.text = date.localDate()
        return cell
    }
    
}
