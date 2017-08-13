//
//  ListInteractor.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/12/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import UIKit

protocol ListItemsInteractor: class {
    var presenter: ListPresentorProtocol? { get set }
    func findUpcomingItems(name: String, password: String)
    func itemDownloaded(user: User?)
}

class ListInteractor: ListItemsInteractor {

    let dataManager: DataDownloader
    weak var presenter: ListPresentorProtocol?

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
