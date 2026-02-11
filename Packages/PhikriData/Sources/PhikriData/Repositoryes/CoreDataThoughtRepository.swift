//
//  File.swift
//  
//
//  Created by Mcbook Pro on 09.02.26.
//

import Foundation
import CoreData
import PhikriDomain


import Foundation
import CoreData
import PhikriDomain

public final actor CoreDataThoughtRepository: ThoughtRepositoryProtocol {
    private let container: NSPersistentContainer
    
    public init(container: NSPersistentContainer = PersistenceController.shared.container) {
        self.container = container
    }
    
    private var backgroundContext: NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
    
    public func fetchAll() async throws -> [Thought] {
        let context = backgroundContext
        let request: NSFetchRequest<ThoughtEntity> = ThoughtEntity.fetchRequest()
        
    
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ThoughtEntity.createdAt, ascending: false)]
        
        return try await context.perform {
            do {
                let results = try context.fetch(request)
                // ვიყენებთ Mapping-ს, რომ Entity გადავიყვანოთ Domain მოდელში
                return results.map { entity in
                    Thought(
                        id: entity.id ?? UUID(),
                        title: entity.title ?? "",
                        body: entity.body ?? "",
                        createdAt: entity.createdAt ?? Date(),
                        updatedAt: entity.updatedAt ?? Date(),
                        mood: Mood(rawValue: entity.moodValue ?? "neutral") ?? .neutral
                    )
                }
            } catch {
                throw DomainError.persistenceFailed(.fetch)
            }
        }
    }
    
    public func save(_ thought: Thought) async throws {
        let context = backgroundContext
        
        try await context.perform {
            let entity = ThoughtEntity(context: context)
            
            entity.id = thought.id
            entity.title = thought.title
            entity.body = thought.body
            entity.createdAt = thought.createdAt
            entity.updatedAt = thought.updatedAt
            entity.moodValue = thought.mood.rawValue
            
            do {
                try context.save()
            } catch {
                throw DomainError.persistenceFailed(.save)
            }
        }
    }
    
    public func delete(id: UUID) async throws {
        let context = backgroundContext
        
        try await context.perform {
            let request: NSFetchRequest<ThoughtEntity> = ThoughtEntity.fetchRequest()
            // ვეძებთ კონკრეტულ Entity-ს ID-ით
            request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            request.fetchLimit = 1
            
            do {
                if let entity = try context.fetch(request).first {
                    context.delete(entity)
                    try context.save()
                }
            } catch {
                throw DomainError.persistenceFailed(.delete)
            }
        }
    }
}
