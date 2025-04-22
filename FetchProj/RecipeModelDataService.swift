//
//  RecipeModelDataService.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation
import Combine

class RecipeModelDataService {
    
    static let instance = RecipeModelDataService()
    @Published var recipeModels: [Recipe] = []
    private let fileManager = RecipeStorageManager.instance
    
    private init() {
        // Try to load cached recipes when service is initialized
        if let cachedRecipes = fileManager.loadRecipes() {
            self.recipeModels = cachedRecipes
        }
    }
    
    func downloadData() async throws -> [Recipe] {
        
        //empty endpoint:
        //let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        
        //malformed endpoint:
        //let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        
        //good endpoint:
        let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        
        guard let url = URL(string: endpoint) else {
            throw recipeError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw recipeError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedRecipes = try decoder.decode(RecipeWrapper.self, from: data)
            
            await MainActor.run {
                self.recipeModels = decodedRecipes.recipes
            }
            
            fileManager.saveRecipes(recipes: decodedRecipes.recipes)
            print("recipes saved")
            
            return decodedRecipes.recipes
        } catch {
            if let cachedRecipes = fileManager.loadRecipes() {
                await MainActor.run {
                    self.recipeModels = cachedRecipes
                }
                return cachedRecipes
            }
            throw recipeError.invalidData
        }
    }
}
