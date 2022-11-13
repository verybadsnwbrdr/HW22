//
//  MainPresenter.swift
//  HW22
//
//  Created by Anton on 13.11.2022.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, model: MainModel)
    
    func numberOfElements() -> Int
    func getName(for row: Int) -> Person
    func addPerson(name: String)
}

class MainPresenter: MainPresenterProtocol {
    
    // MARK: - References
    
    weak var view: MainViewProtocol?
    private var model: MainModel
    
    // MARK: - Properties
    
    private var names: [String] = []
    
    // MARK: - Initializer
    
    required init(view: MainViewProtocol, model: MainModel) {
        self.view = view
        self.model = model
    }
    
    // MARK: - Methods
    
    func numberOfElements() -> Int {
        model.persons.count
    }
    
    func getName(for row: Int) -> Person {
        model.persons[row]
    }
    
    func addPerson(name: String) {
        let person = Person(name: name, age: nil)
        model.persons.append(person)
    }
}
