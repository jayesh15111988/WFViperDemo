//
//  DetailWireframe.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/12/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import UIKit

protocol DetailWireframeProtocol: class {
    func moveToFinalScreen(view: DetailViewProtocol, details: String)
    func dismiss(view: DetailViewProtocol)
}

class DetailWireframe: DetailWireframeProtocol {
    func moveToFinalScreen(view: DetailViewProtocol, details: String) {
        if let _ = view as? UIViewController {
            let interactor: FinalScreenInteractorProtocol = FinalScreenInteractor()
            let wireframe: FinalScreenWireframeProtocol = FinalScreenWireframe()
            let presentor: FinalScreenPresentorProtocol = FinalScreenPresentor(interactor: interactor, wireframe: wireframe, name: details)
            let vc: FinalScreenUpdaterProtocol = FinalScreenViewController(presentor: presentor)

            presentor.view = vc
            interactor.presentor = presentor

            if let view = view as? UIViewController, let vc = vc as? UIViewController {
                view.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    func dismiss(view: DetailViewProtocol) {
        if let view = view as? UIViewController {
            view.dismiss(animated: true, completion: nil)
        }
    }
}
