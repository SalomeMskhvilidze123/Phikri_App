//
//  File.swift
//  
//
//  Created by Mcbook Pro on 05.02.26.
//
import Foundation

public struct Thought: Identifiable, Codable, Equatable {
    public let id: UUID
    public var title: String
    public var body: String
    public let createdAt: Date
    public var updatedAt: Date 
    public var mood: Mood
    
    public init(
        id: UUID = UUID(),
        title: String,
        body: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        mood: Mood
    ) {
        self.id = id
        self.title = title
        self.body = body
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.mood = mood
    }
}

public enum Mood: String, Codable, CaseIterable {
    case sad
    case neutral
    case anxious
    case inspired
    
    public var emoji: String {
        switch self {
        case .sad: return "😢"
        case .neutral: return "😐"
        case .anxious: return "😰"
        case .inspired: return "✨"
        }
    }
}
