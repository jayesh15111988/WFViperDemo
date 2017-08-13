//
//  PostWireframe.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/12/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import UIKit

protocol LoginWireframeProtocol {
    func presentPosts(view: LoginViewProtocol, user: User)
}

class LoginWireframe: LoginWireframeProtocol {
    func presentPosts(view: LoginViewProtocol, user: User) {
        let dataManager: DataDownloader = DataManager()
        let interactor: DetailsInteractorProtocol = DetailsInteractor(dataManager: dataManager)
        let wireframe: DetailWireframeProtocol = DetailWireframe()
        let detailsPresenter: DetailsPresenterProtocol = DetailsPresenter(interactor: interactor, wireframeProtocol: wireframe)
        let detailsVC: DetailViewProtocol = DetailViewController(detailsPresenter: detailsPresenter, user: user)

        interactor.presenter = detailsPresenter
        detailsPresenter.view = detailsVC
        dataManager.itemsDetailsInteractor = interactor

        if let view = view as? UIViewController, let detailsVC = detailsVC as? UIViewController {
            view.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
