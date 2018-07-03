//
//  NSManagedObject+Extension.swift
//  WalletStone
//
//  Created by Andre on 09/06/2018.
//  Copyright © 2018 AndreSamples. All rights reserved.
//

import Foundation
import CoreData

protocol Entity: class {}

extension Entity where Self: NSObject {
    static var entityName: String {
        return String(describing: self)
    }
}

extension NSManagedObject: Entity {}

extension NSManagedObjectContext {
    
    func fetchRequest<T: NSManagedObject>(_ entity: T.Type) -> NSFetchRequest<T> {
        return NSFetchRequest<T>(entityName: entity.entityName)
    }
    
    func fetchAll<T: NSManagedObject>(entity: T.Type) -> [T] {
        let managedContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<T> = self.fetchRequest(T.self)
        
        do {
            let array = try managedContext.fetch(fetchRequest) as [T]
            return array
        } catch let errore {
            print("error FetchRequest \(errore)")
        }
        
        return []
    }
    
    func insert<T : NSManagedObject>(entity: T.Type) -> T {
        guard let object = NSEntityDescription.insertNewObject(forEntityName: entity.entityName, into: self) as? T else {
            fatalError("Could not cast: \(entity.entityName)")
        }
        return object
    }
    
}
