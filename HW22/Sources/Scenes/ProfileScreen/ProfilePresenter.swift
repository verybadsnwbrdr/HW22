//
//  ProfilePresenter.swift
//  HW22
//
//  Created by Anton on 13.11.2022.
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol, model: ManagedModelProtocol, router: RouterProtocol, person: Person)
    
    func saveButtonPressed(_ name: String?, _ birthDay: String?, _ gender: String?, _ imageData: Data?)
    func backToMainScreen()
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - References
    
    private weak var view: ProfileViewProtocol?
    private var router: RouterProtocol?
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
    
//     MARK: - Methods for ViewController
    
    func saveButtonPressed(_ name: String?, _ birthDay: String?, _ gender: String?, _ imageData: Data?) {
        guard person.name != name ||
                person.birthDay != birthDay ||
                person.gender != gender ||
                person.imageData != imageData else { return }
        
        person.name = name
        person.birthDay = birthDay
        person.gender = gender
        person.imageData = imageData
        
        model.updateModel(for: person)
    }
    
    func backToMainScreen() {
        router?.popToRoot()
    }
}
