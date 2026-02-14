//
//  ThoughtViewModel.swift
//  PhikriApp
//
//  Created by Mcbook Pro on 11.02.26.
//

import Foundation
import Combine
import PhikriDomain

@MainActor
class ThoughtViewModel: ObservableObject {
    // MARK: - Published Properties UI აკვირდება ამათ
    @Published var thoughts: [Thought] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Dependencies (DIP პრინციპი)
    private let fetchUseCase: FetchThoughtsUseCase
    private let saveUseCase: SaveThoughtUseCase
    
    init(fetchUseCase: FetchThoughtsUseCase, saveUseCase: SaveThoughtUseCase) {
        self.fetchUseCase = fetchUseCase
        self.saveUseCase = saveUseCase
    }
    
    // MARK: - Actions
    
    /// ბაზიდან ფიქრების წაკითხვა
    func fetchThoughts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            self.thoughts = try await fetchUseCase.execute()
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    /// ახალი ფიქრის დამატებაააა
    func addThought(title: String, body: String, mood: Mood) async {
        isLoading = true
        
        do {
            try await saveUseCase.execute(title: title, body: body, mood: mood)
            await fetchThoughts()
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
