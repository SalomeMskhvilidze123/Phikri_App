//
//  File.swift
//  
//
//  Created by Mcbook Pro on 06.02.26.
//

import Foundation

public enum DomainError: Error {
    //  ვალიდაციის შეცდომები (Business Rules)
    case invalidTitle
    case emptyBody
    
    //  ოპერაციული შეცდომები (Persistence)
    case persistenceFailed(PersistenceAction)
    
    //  მონაცემების არარსებობა
    case notFound
    
    //  გაუთვალისწინებელი შემთხვევა
    case unknown(Error?)
    
    // შიდა დამხმარე ტიპი ოპერაციების იდენტიფიკაციისთვის
    public enum PersistenceAction {
        case save
        case fetch
        case delete
    }
}

// MARK: - LocalizedError მომხმარებლისთვის საჩვენებელი ტექსტები
extension DomainError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidTitle:
            return "სათაური ძალიან მოკლეა (მინიმუმ 3 სიმბოლო)."
        case .emptyBody:
            return "ფიქრის შინაარსი არ შეიძლება იყოს ცარიელი."
        case .notFound:
            return "მოთხოვნილი ჩანაწერი ვერ მოიძებნა."
        case .unknown(let error):
            return error?.localizedDescription ?? "მოხდა გაუთვალისწინებელი შეცდომა."
            
        case .persistenceFailed(let action):
            switch action {
            case .save:
                return "მონაცემების შენახვა ვერ მოხერხდა."
            case .fetch:
                return "მონაცემების წაკითხვა ვერ მოხერხდა."
            case .delete:
                return "მონაცემების წაშლა ვერ მოხერხდა."
            }
        }
    }
}
