//
//  File.swift
//  
//
//  Created by Mcbook Pro on 09.02.26.
//

import Foundation
import CoreData
import PhikriDomain


public final class CoreDataThoughtRepository {
    private let container: NSPersistentContainer
    
    public init(container: NSPersistentContainer = PersistenceController.shared.container) {
        self.container = container
    }
    
    // დამხმარე თვისება კონტექსტზე სწრაფი წვდომისთვის
    private var context: NSManagedObjectContext {
        container.viewContext
    }
}
@available(iOS 13.0.0, *)

extension CoreDataThoughtRepository:ThoughtRepositoryProtocol {

    public func fetchAll() async throws -> [Thought] {
        let request: NSFetchRequest<ThoughtEntity> = ThoughtEntity.fetchRequest()
        
        if #available(iOS 15.0, *) {
            return try await context.perform {
                do {
                    let results = try self.context.fetch(request)
                    // თითოეულ Entity-ს ვაქცევთ დომენის მოდელად
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
        } else {
            // Fallback on earlier versions
        }
    }
    
    public func save(_ thought: Thought) async throws {
        // Core Data-სთან მუშაობისას აუცილებელია სწორი Thread-ის გამოყენება
        if #available(iOS 15.0, *) {
            try await context.perform {
                let entity = ThoughtEntity(context: self.context)
                
                // ვავსებთ Entity-ს მონაცემებით
                entity.id = thought.id
                entity.title = thought.title
                entity.body = thought.body
                entity.createdAt = thought.createdAt
                entity.updatedAt = thought.updatedAt
                entity.moodValue = thought.mood.rawValue
                
                do {
                    try self.context.save()
                } catch {
                    // აი აქ ხდება ერორების მეფინგი, რაზეც გუშინ ვიმსჯელეთ!
                    throw DomainError.persistenceFailed(.save)
                }
            }
        } else {
            // Fallback on earlier versions
        }
        }
    
    public func delete(id: UUID) async throws {
        <#code#>
    }
    
    
}
