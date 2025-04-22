//
//  RecipeModelDataService.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation
import os

class RecipeModelDataService {
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: RecipeModelDataService.self))
    
    static let instance = RecipeModelDataService()
    @Published var recipeModels: [Recipe] = []
    private let fileManager = RecipeStorageManager.instance
    
    private init() {
        if let savedRecipes = fileManager.loadRecipes() {
            self.recipeModels = savedRecipes
        }
    }
    
    func downloadData(from endpoint: String = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") async throws -> [Recipe] {
        
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
            Self.logger.notice("Recipes successfully saved")
            return decodedRecipes.recipes
        } catch {
            if let savedRecipes = fileManager.loadRecipes() {
                await MainActor.run {
                    self.recipeModels = savedRecipes
                }
                Self.logger.notice("Used saved recipes")
                return savedRecipes
            }
            Self.logger.error("Unable to download recipes or get saved recipes")
            throw recipeError.invalidData
        }
    }
}
