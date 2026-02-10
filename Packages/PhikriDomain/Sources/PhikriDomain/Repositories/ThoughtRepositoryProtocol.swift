//
//  File.swift
//  
//
//  Created by Mcbook Pro on 05.02.26.
//

import Foundation
@available(iOS 13.0.0, *)
public protocol ThoughtRepositoryProtocol {
    func fetchAll() async throws -> [Thought]
    func save( _ thought:Thought) async throws
    func delete(id: UUID) async throws
    
}


