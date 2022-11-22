//
//  Identifiable.swift
//  HW22
//
//  Created by Anton on 20.11.2022.
//

//import Foundation

extension Identifiable {
    static var identifier: String {
        String(describing: Self.self)
    }
}
