//
//  MainModel.swift
//  HW22
//
//  Created by Anton on 13.11.2022.
//

import Foundation

struct MainModel {
    var persons: [Person] = []
}

struct Person {
    let name: String
    let age: Int?
}
