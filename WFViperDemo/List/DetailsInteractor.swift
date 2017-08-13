//
//  DetailsInteractor.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/12/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import Foundation

protocol DetailsInteractorProtocol: class {
    var presenter: DetailsPresenterProtocol? { get set }
    func fetchDetails(user: User)
    func detailsForUserFetched(result: [String])
}

class DetailsInteractor: DetailsInteractorProtocol {

    weak var presenter: DetailsPresenterProtocol?
    let dataManager: DataDownloader

    init(dataManager: DataDownloader) {
        self.dataManager = dataManager
    }

    func fetchDetails(user: User) {
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.dataManager.downloadItemsFor(name: user.username)
        }
    }

    func detailsForUserFetched(result: [String]) {
        self.presenter?.detailsLoaded(details: result)
    }
}
