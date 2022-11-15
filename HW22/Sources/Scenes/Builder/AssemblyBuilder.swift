//
//  ModuleBilder.swift
//  HW22
//
//  Created by Anton on 13.11.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createProfileModule(router: RouterProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let model = ManagedModel()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, model: model, router: router)
        view.presenter = presenter
        return view
    }
    
    func createProfileModule(router: RouterProtocol) -> UIViewController {
        let model = ManagedModel()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, model: model, router: router)
        view.presenter = presenter
        return view
    }
}
