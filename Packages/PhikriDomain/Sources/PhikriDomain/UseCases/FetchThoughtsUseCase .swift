//
//  File.swift
//  
//
//  Created by Mcbook Pro on 05.02.26.
//

import Foundation

public final class FetchThoughtsUseCase {
    private let repository: ThoughtRepositoryProtocol

    public init(repository: ThoughtRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() async throws -> [Thought] {
        return try await repository.fetchAll()
    }
}
