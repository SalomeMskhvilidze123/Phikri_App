//
//  File.swift
//  
//
//  Created by Mcbook Pro on 09.02.26.
//

import Foundation
import CoreData

public struct PersistenceController {
    
    public static let shared = PersistenceController()

    public let container: NSPersistentContainer

    public init(inMemory: Bool = false) {
        guard let modelURL = Bundle.module.url(forResource: "PhikriModel", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("PhikriModel ვერ მოიძებნა PhikriData პაკეტში")
        }


        container = NSPersistentContainer(name: "PhikriModel", managedObjectModel: model)
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // 4. ვტვირთავთ ბაზას
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Core Data-ს ჩატვირთვის შეცდომა: \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
