//
//  DetailsPresenter.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/12/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import Foundation

protocol DetailsPresenterProtocol: class {
    var view: DetailViewProtocol? { get set }
    var selectedName: String? { get set }
    var user: User { get set }
    var userDetails: [String] { get set }
    func presentDetails(user: User)
    func detailsLoaded(details: [String])
    func indexSelected(_ index: Int)
    func moveToNextScreen()
    func dismiss()
}

class DetailsPresenter: DetailsPresenterProtocol {

    weak var view: DetailViewProtocol?
    let interactor: DetailsInteractorProtocol
    let wireframe: DetailWireframeProtocol
    var selectedName: String?
    var user: User
    var userDetails: [String]

    init(interactor: DetailsInteractorProtocol, wireframeProtocol: DetailWireframeProtocol, user: User) {
        self.interactor = interactor
        self.wireframe = wireframeProtocol
        self.userDetails = []
        self.user = user
    }

    func presentDetails(user: User) {
        self.view?.showLoading()
        self.interactor.fetchDetails(user: user)
    }

    func detailsLoaded(details: [String]) {
        self.view?.hideLoading()
        self.userDetails = details
        self.view?.showDetails(userDetails: details)
    }

    func moveToNextScreen() {
        guard let name = self.selectedName, name.characters.count > 0 else {
            self.view?.showNextScreenError()
            return
        }
        self.wireframe.moveToFinalScreen(view: view!, details: name)
    }

    func dismiss() {
        self.wireframe.dismiss(view: view!)
    }

    func indexSelected(_ index: Int) {
        self.selectedName = self.userDetails[index]
        self.view?.selectedNameUpdater()
    }
}
