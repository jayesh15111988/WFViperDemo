//
//  FinalScreenInteractor.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/13/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import Foundation

protocol FinalScreenInteractorProtocol: class {
    var presentor: FinalScreenPresentorProtocol? { get set }
    func appendName(_ value: String)
}

class FinalScreenInteractor: FinalScreenInteractorProtocol {

    weak var presentor: FinalScreenPresentorProtocol?

    func appendName(_ value: String) {
        var updatedValue = value
        updatedValue = updatedValue + updatedValue
        self.presentor?.nameUpdated(updatedValue)
    }
}
