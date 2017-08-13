//
//  ViewController.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/9/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import UIKit

protocol PostListViewProtocol: class {
    func showLoadingSpinner()
    func hideLoadingSpinner()
    func showUserWithSuccess(user: User)
    func showUserWithError(_ error: String)
}

class ViewController: UIViewController {

    let presenter: ListPresentorProtocol
    let activityIndicatorView: UIActivityIndicatorView
    var user: User?
    let loginSuccessfulLabel: UILabel
    let button: UIButton
    let usernameTextField: UITextField
    let passwordTextField: UITextField

    init(presenter: ListPresentorProtocol) {
        self.presenter = presenter
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        loginSuccessfulLabel = UILabel()
        loginSuccessfulLabel.translatesAutoresizingMaskIntoConstraints = false
        loginSuccessfulLabel.numberOfLines = 0

        usernameTextField = UITextField()
        passwordTextField = UITextField()
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        self.activityIndicatorView.activityIndicatorViewStyle = .whiteLarge
        self.view.addSubview(activityIndicatorView)
        self.view.addSubview(loginSuccessfulLabel)
        self.view.addSubview(button)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)

        usernameTextField.text = "jayesh"
        passwordTextField.text = "password"

        self.button.addTarget(self, action: #selector(performLogin), for: .touchUpInside)

        self.view.addConstraint(NSLayoutConstraint(item: activityIndicatorView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: activityIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0))

        let views = ["label": loginSuccessfulLabel, "button": button, "username": usernameTextField, "password": passwordTextField]

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[password]-|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[username(>=0)]-[password(>=0)]-[label(>=0)]-[button(44)]", options: [], metrics: nil, views: views))
    }

    @objc private func performLogin() {
        self.presenter.executeFindItems(name: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }

    func showUserWithSuccess(user: User) {
        self.user = user
        self.loginSuccessfulLabel.text = "Login Successful"
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.goToNextScreen()
        }
    }

    func showUserWithError(_ error: String) {
        self.loginSuccessfulLabel.text = error
    }

    private func goToNextScreen() {
        guard let user = user else { return }
        self.presenter.showList(user: user)
    }
}

extension ViewController: PostListViewProtocol {
    func showLoadingSpinner() {
        self.activityIndicatorView.startAnimating()
    }

    func hideLoadingSpinner() {
        self.activityIndicatorView.stopAnimating()
    }

}
