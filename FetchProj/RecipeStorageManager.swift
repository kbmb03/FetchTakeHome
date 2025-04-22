//
//  RecipeStorageManager.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/17/25.
//

import Foundation
import SwiftUI

class RecipeStorageManager {
    
    static let instance = RecipeStorageManager()
    private let folderName = "recipe_data"
    private let fileName = "cached_recipes.json"
    
    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("Created recipe data folder")
            } catch {
                print("Error creating recipe data folder: \(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    private func getRecipesPath() -> URL? {
        guard let folder = getFolderPath() else { return nil }
        return folder.appendingPathComponent(fileName)
    }
    
    func saveRecipes(recipes: [Recipe]) {
        guard let url = getRecipesPath() else { return }
        
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(recipes)
            try data.write(to: url)
            print("Recipes saved")
        } catch {
            print("Error saving recipes to file: \(error)")
        }
    }
    
    func loadRecipes() -> [Recipe]? {
        guard
            let url = getRecipesPath(),
            FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let recipes = try decoder.decode([Recipe].self, from: data)
            print("recipes loaded")
            return recipes
        } catch {
            print("Error loading recipes from file: \(error)")
            return nil
        }
    }
    
    func removeAllData() {
        guard let folder = getFolderPath() else { return }
        try? FileManager.default.removeItem(at: folder)
        createFolderIfNeeded()
        print("Recipe cache cleared")
    }
}
