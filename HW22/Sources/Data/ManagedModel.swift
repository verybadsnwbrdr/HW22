//
//  MainModel.swift
//  HW22
//
//  Created by Anton on 13.11.2022.
//

import Foundation
import CoreData

protocol ManagedModelProtocol: AnyObject {
    func addModel(with name: String)
    func saveContext()
    func getModels() -> [Person]
    func deleteFromContext(person: Person)
    func updateModel(for person: Person)
}

final class ManagedModel: ManagedModelProtocol {    
    
    // MARK: - Properties
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private let fetchRequest = Person.fetchRequest()
    private lazy var context: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    private var managedObject: Person {
        Person(context: context)
    }
    
    // MARK: - CoreData
    
    func addModel(with name: String) {
        managedObject.name = name
        saveContext()
    }
    
    func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    func deleteFromContext(person: Person) {
        context.delete(person)
        saveContext()
    }
    
    func getModels() -> [Person] {
        guard let models = try? context.fetch(fetchRequest) else { return [] }
        return models
    }
    
    func updateModel(for person: Person) {
        let objectToUpdate = context.object(with: person.objectID) as? Person
        objectToUpdate?.name = person.name
        objectToUpdate?.birthDay = person.birthDay
        objectToUpdate?.gender = person.gender
        objectToUpdate?.imageData = person.imageData
        saveContext()
    }
}

