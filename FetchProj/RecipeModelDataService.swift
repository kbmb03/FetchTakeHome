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
    private let fileManager = RecipeDataFileManager.instance
    
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
        let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        
        //good endpoint:
        //let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        
        
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
            self.recipeModels = decodedRecipes.recipes
            
            // Save the fresh data to cache
            fileManager.saveRecipes(recipes: decodedRecipes.recipes)
            print("recipes saved")
            
            return decodedRecipes.recipes
        } catch {
            // If network request fails and we have cached data, return that
            if let cachedRecipes = fileManager.loadRecipes() {
                return cachedRecipes
            }
            throw recipeError.invalidData
        }
    }
}
