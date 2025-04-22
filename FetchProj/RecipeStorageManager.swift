//
//  RecipeStorageManager.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/17/25.
//

import Foundation
import SwiftUI
import os

class RecipeStorageManager {
    
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.kd.FetchProj", category: String(describing: RecipeStorageManager.self))
    
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
                Self.logger.notice("successfully created new folder")
            } catch {
                Self.logger.error("Failed to create folder: \(error)")
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
            Self.logger.notice("Recipes successfully saved")
        } catch {
            Self.logger.error("Error saving recipes to file: \(error)")
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
            Self.logger.notice("recipes successfully loaded")
            return recipes
        } catch {
            Self.logger.error("Error loading recipes from file: \(error)")
            return nil
        }
    }
    
    func removeAllData() {
        guard let folder = getFolderPath() else { return }
        try? FileManager.default.removeItem(at: folder)
        createFolderIfNeeded()
        Self.logger.notice("Recipe cache cleared")
    }
}
