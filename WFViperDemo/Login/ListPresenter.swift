//
//  ListPresenter.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/12/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import UIKit

protocol ListPresentorProtocol: class {
    var view: PostListViewProtocol? { get set }
    func executeFindItems(name: String, password: String)
    func showList(user: User)
    func itemDownloaded(user: User?)
}

class ListPresenter: ListPresentorProtocol {

    weak var view: PostListViewProtocol?
    let interactor: ListItemsInteractor
    let wireframe: WireFrameProtocol

    init(interactor: ListItemsInteractor, wireframe: WireFrameProtocol) {
        self.interactor = interactor
        self.wireframe = wireframe
    }

    func executeFindItems(name: String, password: String) {
        self.view?.showLoadingSpinner()
        self.interactor.findUpcomingItems(name: name, password: password)
    }

    func showList(user: User) {
        self.wireframe.presentPosts(view: view!, user: user)        
    }

    func itemDownloaded(user: User?) {
        self.view?.hideLoadingSpinner()
        if let user = user {
            self.view?.showUserWithSuccess(user: user)
        } else {
            self.view?.showUserWithError("Failed to get user object")
        }
    }
}
