//
//  DataManager.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/12/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import UIKit

protocol DataDownloader: class {
    func downloadItem(name: String, password: String)
    func downloadItemsFor(name: String)
    var listItemsInteractor: LoginInteractorProtocol? { get set }
    var itemsDetailsInteractor: DetailsInteractorProtocol? { get set }
}

class DataManager: DataDownloader {

    weak var listItemsInteractor: LoginInteractorProtocol?
    weak var itemsDetailsInteractor: DetailsInteractorProtocol?

    func downloadItem(name: String, password: String) {
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            if name == "foo" && password == "password" {
                self.listItemsInteractor?.itemDownloaded(user: User(username: name, password: "password"))
            } else {
                self.listItemsInteractor?.itemDownloaded(user: nil)
            }
        }
    }

    func downloadItemsFor(name: String) {
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.itemsDetailsInteractor?.detailsForUserFetched(result: ["A", "B", "C", "D", "E"])
        }
    }
}
