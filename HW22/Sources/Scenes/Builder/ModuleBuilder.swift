//
//  ModuleBilder.swift
//  HW22
//
//  Created by Anton on 13.11.2022.
//

import UIKit

protocol ModuleBuilderProtocol {
    static func createMain() -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    static func createMain() -> UIViewController {
        let model = MainModel()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
