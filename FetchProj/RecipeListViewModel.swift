//
//  RecipeListViewModel.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation

@MainActor
class RecipeListViewModel: ObservableObject {
    
    @Published var dataArray: [Recipe] = []
    @Published var error: recipeError?
    
    let dataService = RecipeModelDataService.instance
    
    init() {
        Task {
            await downloadData()
        }
    }
    
    func downloadData() async {
        
        do {
            let recipes = try await dataService.downloadData()
            self.dataArray = recipes
            self.error = nil
        } catch let error as recipeError {
            print("failed to download data: \(error)")
            self.error = error
        } catch {
            self.error = .other(error)
        }
    }
    
}
