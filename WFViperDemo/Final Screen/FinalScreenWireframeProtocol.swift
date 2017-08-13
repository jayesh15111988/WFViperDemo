//
//  FinalScreenWireframeProtocol.swift
//  WFViperDemo
//
//  Created by Jayesh Kawli on 8/13/17.
//  Copyright © 2017 Wayfair. All rights reserved.
//

import UIKit

protocol FinalScreenWireframeProtocol {
    func goBack(view: FinalScreenUpdaterProtocol)
    func goToHomeScreen(view: FinalScreenUpdaterProtocol)
}

class FinalScreenWireframe: FinalScreenWireframeProtocol {
    func goBack(view: FinalScreenUpdaterProtocol) {
        if let vc = view as? UIViewController {
            vc.navigationController?.popViewController(animated: true)
        }
    }

    func goToHomeScreen(view: FinalScreenUpdaterProtocol) {
        if let vc = view as? UIViewController {
            vc.navigationController?.popToRootViewController(animated: true)
        }
    }
}
