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
    func showProfileScreen(person: Person)
    func popToRoot()
}

final class Router: RouterProtocol {
    
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
    
    func showProfileScreen(person: Person) {
        guard let navigationController = navigationController,
              let profileViewController = assemblyBuilder?.createProfileModule(router:  self, person: person) else { return }
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}

