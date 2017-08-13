//
//  DetailsPresenter.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/12/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import Foundation

protocol DetailsPresenter: class {
    var view: DetailViewProtocol? { get set }
    var selectedName: String? { get set }
    func presentDetails(user: User)
    func detailsLoaded(details: [String])
    func nameSelected(_ value: String)
    func moveToNextScreen()
    func dismiss()
}

class DetailsPresenterClass: DetailsPresenter {

    weak var view: DetailViewProtocol?
    let interactor: DetailsInteractorProtocol
    let wireframe: DetailWireframeProtocol
    var selectedName: String?

    init(interactor: DetailsInteractorProtocol, wireframeProtocol: DetailWireframeProtocol) {
        self.interactor = interactor
        self.wireframe = wireframeProtocol
    }

    func presentDetails(user: User) {
        self.view?.showLoading()
        self.interactor.fetchDetails(user: user)
    }

    func detailsLoaded(details: [String]) {
        self.view?.hideLoading()
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

    func nameSelected(_ value: String) {
        self.selectedName = value
        self.view?.selectedNameUpdater()
    }
}
