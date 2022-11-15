//
//  MainModel.swift
//  HW22
//
//  Created by Anton on 13.11.2022.
//

import Foundation
import CoreData

protocol ManagedModelProtocol: AnyObject {
    var managedObject: Person { get }
    
    func saveContext()
    func getModels() -> [Person]
    func deleteFromContext(person: Person)
}

final class ManagedModel: ManagedModelProtocol {
    
    // MARK: - Properties
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Person.identifier)
    
    private lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    var managedObject: Person {
        Person(entity: entityForName(entityName: Person.identifier),
               insertInto: context)
    }
    
    // MARK: - Entity
    
    private func entityForName(entityName: String) -> NSEntityDescription {
        guard let entityDescription = NSEntityDescription.entity(
            forEntityName: entityName,
            in: context) else { return NSEntityDescription() }
        return entityDescription
    }
    
    // MARK: - CoreData
    
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
        guard let models = try? context.fetch(fetchRequest) as? [Person] else { return [] }
        return models
    }
}

