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
    init(view: MainViewProtocol, model: ManagedModelProtocol, router: RouterProtocol)
    
    func getPersons() -> [Person]
    func deletePerson(at row: Int)
    
    func addPerson(name: String)
    func numberOfElements() -> Int
    func getPerson(for row: Int) -> Person
    
    func tapFor(row: Int)
}

class MainPresenter: MainPresenterProtocol {
    
    // MARK: - References
    
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    private var model: ManagedModelProtocol
    
    // MARK: - Properties
    
    private var persons: [Person] = []
    
    // MARK: - Initializer
    
    required init(view: MainViewProtocol,
                  model: ManagedModelProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.model = model
        self.router = router
        
        persons = getPersons()
    }
    
    // MARK: - Methods for Model
    
    func getPersons() -> [Person] {
        model.getModels()
    }
    
    func deletePerson(at row: Int) {
        let person = persons.remove(at: row)
        model.deleteFromContext(person: person)
    }
    
    // MARK: - Methods for ViewController
    
    func addPerson(name: String) {
        model.managedObject.name = name
        model.saveContext()
        persons = getPersons()
    }
    
    func numberOfElements() -> Int {
        persons.count
    }
    
    func getPerson(for row: Int) -> Person {
        persons[row]
    }
    
    // MARK: - Methods for Navigation
    
    func tapFor(row: Int) {
        let person = persons[row]
        router?.showProfileScreen(person: person)
    }
}
