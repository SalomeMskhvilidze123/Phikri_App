//
//  File.swift
//  
//
//  Created by Mcbook Pro on 05.02.26.
//

import Foundation

@available(iOS 13.0.0, *)
public final class SaveThoughtUseCase {
    private let repository: ThoughtRepositoryProtocol

    public init(repository: ThoughtRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(title: String, body: String, mood: Mood) async throws {
        
        let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
        
        guard trimmedTitle.count >= 3 else {
            throw DomainError.invalidTitle
        }
        
        guard !body.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw DomainError.emptyBody
        }

        //  მოდელის შექმნა
        let newThought = Thought(
            title: trimmedTitle,
            body: body,
            mood: mood
        )

        //  შენახვა  ვიყენებთ სწორ მეთოდს პროტოკოლიდან
        do {
            try await repository.save(newThought)
        } catch {
            // თუ რეპოზიტორიამ რამე ტექნიკური ერორი ისროლა, ჩვენ მას "ვთარგმნით"
            throw DomainError.persistenceFailed(.save)
        }
    }
}
