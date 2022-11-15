//
//  ProfilePresenter.swift
//  HW22
//
//  Created by Anton on 13.11.2022.
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol, model: ManagedModelProtocol, router: RouterProtocol, person: Person)
    
//    func getPersons() -> [Person]
//    func deletePerson(at row: Int)
//
//    func addPerson(name: String)
//    func numberOfElements() -> Int
//    func getPerson(for row: Int) -> Person
}

class ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - References
    
    weak var view: ProfileViewProtocol?
    var router: RouterProtocol?
    private var model: ManagedModelProtocol
    
    // MARK: - Properties
    
    private var person: Person
    
    // MARK: - Initializer
    
    required init(view: ProfileViewProtocol,
                  model: ManagedModelProtocol,
                  router: RouterProtocol,
                  person: Person) {
        self.view = view
        self.model = model
        self.router = router
        self.person = person
        
        view.setupProfileView(for: person)
    }
    
//    // MARK: - Methods for Model
//
//    func getPersons() -> [Person] {
//        model.getModels()
//    }
//
//    func deletePerson(at row: Int) {
//        let person = persons.remove(at: row)
//        model.deleteFromContext(person: person)
//    }
//
//    // MARK: - Methods for ViewController
//
//    func addPerson(name: String) {
//        model.managedObject.name = name
//        model.saveContext()
//        persons = getPersons()
//    }
//
//    func numberOfElements() -> Int {
//        persons.count
//    }
//
//    func getPerson(for row: Int) -> Person {
//        persons[row]
//    }
}
