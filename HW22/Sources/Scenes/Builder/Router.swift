//
//  Router.swift
//  HW22
//
//  Created by Anton on 15.11.2022.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
    
    func initialViewController()
    func showProfileScreen()
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        guard let navigationController = navigationController,
              let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
        navigationController.viewControllers = [mainViewController]
    }
    
    func showProfileScreen() {
        guard let navigationController = navigationController,
              let mainViewController = assemblyBuilder?.createMainModule(router:  self) else { return }
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}

