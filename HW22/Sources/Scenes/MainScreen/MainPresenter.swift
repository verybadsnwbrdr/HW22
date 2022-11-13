//
//  MainPresenter.swift
//  HW22
//
//  Created by Anton on 13.11.2022.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, model: MainModel)
}

class MainPresenter: MainPresenterProtocol {
    
    // MARK: - References
    
    weak var view: MainViewProtocol?
    private let model: MainModel
    
    // MARK: - Initializer
    
    required init(view: MainViewProtocol, model: MainModel) {
        self.view = view
        self.model = model
    }
    
}
