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
    
    private init() {}
    
    func downloadData() async throws -> [Recipe] {
        let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        guard let url = URL(string: endpoint) else {
            throw recipeError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw recipeError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedRecipes = try decoder.decode(RecipeWrapper.self, from: data)
            self.recipeModels = decodedRecipes.recipes
            return decodedRecipes.recipes
            //error log invalid recipes??
        } catch {
            throw recipeError.invalidData
        }
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
