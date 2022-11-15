//
//  Person+CoreDataProperties.swift
//  HW22
//
//  Created by Anton on 14.11.2022.
//
//

import Foundation
import CoreData

extension Person {
 
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: Self.identifier)
    }

    @NSManaged public var name: String?
    @NSManaged public var birthDay: String?
    @NSManaged public var gender: String?

}

extension Person : Identifiable {

}
