//
//  FinalScreenPresentorProtocol.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/13/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import Foundation

protocol FinalScreenPresentorProtocol: class {
    var originalName: String { get set }
    var updatedName: String { get set }
    var currentName: String { get set }
    var view: FinalScreenUpdaterProtocol? { get set }
    func appendName()
    func resetName()
    func goOneScreenBack()
    func goToHomePage()
    func nameUpdated(_ value: String)
}

class FinalScreenPresentor: FinalScreenPresentorProtocol {
    weak var view: FinalScreenUpdaterProtocol?
    var originalName: String
    var updatedName: String
    var currentName: String
    let interactor: FinalScreenInteractorProtocol
    let wireframe: FinalScreenWireframeProtocol

    init(interactor: FinalScreenInteractorProtocol, wireframe: FinalScreenWireframeProtocol, name: String) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.currentName = name
        self.originalName = name
        self.updatedName = name
    }

    func appendName() {
        self.interactor.appendName(self.currentName)
    }

    func nameUpdated(_ value: String) {
        self.currentName = value
        self.view?.update(with: FinalScreenViewModel(successMessage: "Success name appened", operationPerformed: "Append", resultMessage: value))
    }

    func resetName() {
        guard self.currentName != self.originalName else { return }
        self.currentName = self.originalName
        self.view?.update(with: FinalScreenViewModel(successMessage: "Success name reset", operationPerformed: "Reset", resultMessage: self.currentName))
    }

    func goOneScreenBack() {
        self.view?.update(with: FinalScreenViewModel(successMessage: "Going one screen back", operationPerformed: "One screen back", resultMessage: "Back"))
        self.wireframe.goBack(view: view!)
    }

    func goToHomePage() {
        self.view?.update(with: FinalScreenViewModel(successMessage: "Going home page", operationPerformed: "Home page back", resultMessage: "Home"))
        self.wireframe.goToHomeScreen(view: view!)
    }
}
