//
//  ListInteractor.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/12/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import UIKit

protocol LoginInteractorProtocol: class {
    var presenter: LoginPresentorProtocol? { get set }
    func findUpcomingItems(name: String, password: String)
    func itemDownloaded(user: User?)
}

class LoginInteractor: LoginInteractorProtocol {

    let dataManager: DataDownloader
    weak var presenter: LoginPresentorProtocol?

    init(dataManager: DataDownloader) {
        self.dataManager = dataManager
    }

    func findUpcomingItems(name: String, password: String) {
        self.dataManager.downloadItem(name: name, password: password)
    }

    func itemDownloaded(user: User?) {
        self.presenter?.itemDownloaded(user: user)
    }
}
