//
//  ListPresenter.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/12/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import UIKit

protocol LoginPresentorProtocol: class {
    var view: LoginViewProtocol? { get set }
    var user: User? { get set }
    func executeFindItems(name: String, password: String)
    func showList()
    func itemDownloaded(user: User?)
}

class LoginPresenter: LoginPresentorProtocol {

    weak var view: LoginViewProtocol?
    let interactor: LoginInteractorProtocol
    let wireframe: LoginWireframeProtocol
    var user: User?

    init(interactor: LoginInteractorProtocol, wireframe: LoginWireframeProtocol) {
        self.interactor = interactor
        self.wireframe = wireframe
    }

    func executeFindItems(name: String, password: String) {
        self.view?.showLoadingSpinner()
        self.interactor.findUpcomingItems(name: name, password: password)
    }

    func showList() {
        guard let user = self.user else {
            self.view?.showUserWithError("User selected is nil, cannot proceed")
            return
        }
        self.wireframe.presentPosts(view: view!, user: user)
    }

    func itemDownloaded(user: User?) {
        self.user = user
        self.view?.hideLoadingSpinner()
        if let user = user {
            self.view?.showUserWithSuccess(viewModel: LoginViewModel(user: user, successMessage: "Login Successful", titleMessage: "Welcome Back"))
        } else {
            self.view?.showUserWithError("Failed to get user object")
        }
    }
}
