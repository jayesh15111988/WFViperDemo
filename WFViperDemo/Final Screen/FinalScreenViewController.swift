//
//  FinalScreenViewController.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/13/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import UIKit

protocol FinalScreenUpdaterProtocol: class {
    func update(with viewModel: FinalScreenViewModel)
}

class FinalScreenViewController: UIViewController, FinalScreenUpdaterProtocol {

    let label: UILabel
    let backButton: UIButton
    let homeButton: UIButton
    let appendNameButton: UIButton
    let resetNameButton: UIButton
    let presentor: FinalScreenPresentorProtocol

    init(presentor: FinalScreenPresentorProtocol) {
        self.presentor = presentor
        self.label = UILabel()
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.backButton = UIButton()
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.homeButton = UIButton()
        self.homeButton.translatesAutoresizingMaskIntoConstraints = false
        self.appendNameButton = UIButton()
        self.appendNameButton.translatesAutoresizingMaskIntoConstraints = false
        self.resetNameButton = UIButton()
        self.resetNameButton.translatesAutoresizingMaskIntoConstraints = false
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .blue

        self.view.addSubview(label)
        self.view.addSubview(backButton)
        self.view.addSubview(homeButton)
        self.view.addSubview(appendNameButton)
        self.view.addSubview(resetNameButton)

        self.backButton.setTitle("Back", for: .normal)
        self.homeButton.setTitle("Home", for: .normal)
        self.appendNameButton.setTitle("Append", for: .normal)
        self.resetNameButton.setTitle("Reset", for: .normal)

        self.label.numberOfLines = 0
        self.label.text = self.presentor.currentName
        self.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.homeButton.addTarget(self, action: #selector(homeButtonPressed), for: .touchUpInside)
        self.appendNameButton.addTarget(self, action: #selector(appendNameButtonPressed), for: .touchUpInside)
        self.resetNameButton.addTarget(self, action: #selector(resetNameButtonPressed), for: .touchUpInside)

        let views = ["label": label, "backButton": backButton, "homeButton": homeButton, "appendButton": appendNameButton, "resetButton": resetNameButton]

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[backButton]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[homeButton]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[appendButton]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[resetButton]-|", options: [], metrics: nil, views: views))

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-84-[label(>=0)]-[appendButton(44)]-[resetButton(44)]-[backButton(44)]-[homeButton(44)]", options: [], metrics: nil, views: views))

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func backButtonPressed() {
        self.presentor.goOneScreenBack()
    }

    @objc private func homeButtonPressed() {
        self.presentor.goToHomePage()
    }

    @objc private func resetNameButtonPressed() {
        self.presentor.resetName()
    }

    @objc private func appendNameButtonPressed() {
        self.presentor.appendName()
    }

    func update(with viewModel: FinalScreenViewModel) {
        print(viewModel.successMessage)
        self.label.text = viewModel.resultMessage
        self.title = viewModel.operationPerformed
    }

}
