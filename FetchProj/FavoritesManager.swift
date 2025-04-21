//
//  FavoritesManager.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/18/25.
//

import Foundation

@Observable
class FavoritesManager {
    
    static let shared = FavoritesManager()

    private var favoriteRecipes: Set<String>
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
        }
    }
        
    var favoriteRecipeIDs: Set<String> {
        favoriteRecipes
    }
}
