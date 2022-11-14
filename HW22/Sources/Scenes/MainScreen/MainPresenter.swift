//
//  MainPresenter.swift
//  HW22
//
//  Created by Anton on 13.11.2022.
//

import Foundation
import CoreData
//import UIKit

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, model: ManagedModelProtocol)
    
    func numberOfElements() -> Int
    func getName(for row: Int) -> Person
    func addPerson(name: String)
    func deletePerson(at row: Int)
}

class MainPresenter: MainPresenterProtocol {
    
    // MARK: - References
    
    weak var view: MainViewProtocol?
    private var model: ManagedModelProtocol
    
    // MARK: - Properties
    
    private var names: [String] = []
    
    // MARK: - Initializer
    
    required init(view: MainViewProtocol, model: ManagedModelProtocol) {
        self.view = view
        self.model = model
    }
    
    // MARK: - Methods
    
    func numberOfElements() -> Int {
        model.getModels().count
    }
    
    func getName(for row: Int) -> Person {
        model.getModels()[row]
    }
    
    func addPerson(name: String) {
        model.managedObject.name = name
        model.saveContext()
    }
    
    func deletePerson(at row: Int) {
        model.deleteContext(at: row)
    }
}
