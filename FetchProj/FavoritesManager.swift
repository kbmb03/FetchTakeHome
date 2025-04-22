//
//  FavoritesManager.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/18/25.
//

import Foundation
import os

class FavoritesManager: ObservableObject {
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: FavoritesManager.self))
    
    static let shared = FavoritesManager()

    @Published private(set) var favoriteRecipes: Set<String>
    private let key = "Favorites"

    private init() {
        if let favoritesData = UserDefaults.standard.data(forKey: key),
           let decodedFavoriteRecipes = try? JSONDecoder().decode(Set<String>.self, from: favoritesData) {
            favoriteRecipes = decodedFavoriteRecipes
        } else {
            favoriteRecipes = []
        }
    }

    func contains(_ recipe: Recipe) -> Bool {
        favoriteRecipes.contains(recipe.uuid)
    }

    func add(_ recipe: Recipe) {
        print("recipe is: \(recipe.name)")
        favoriteRecipes.insert(recipe.uuid)
        save()
    }

    func remove(_ recipe: Recipe) {
        favoriteRecipes.remove(recipe.uuid)
        save()
    }
        
    func toggle(_ recipe: Recipe) {
        if contains(recipe) {
            remove(recipe)
        } else {
            add(recipe)
        }
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(favoriteRecipes) {
            UserDefaults.standard.set(encoded, forKey: key)
            Self.logger.info("Successfully saved favorites list")
        } else {
            Self.logger.error("Failed to save favorites")
        }
    }
        
    var favoriteRecipeIDs: Set<String> {
        favoriteRecipes
    }
}
