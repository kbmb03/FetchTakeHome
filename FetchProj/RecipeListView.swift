//
//  RecipeListView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/17/25.
//

import SwiftUI

struct RecipeListView: View {
    let recipes: [Recipe]
    @State private var favoritesManager = FavoritesManager.shared
    @State private var showFavoritesOnly = false
    
    var filteredRecipes: [Recipe] {
        guard showFavoritesOnly else { return recipes }
        return recipes.filter { favoritesManager.contains($0) }
    }
    
    var body: some View {
        List(filteredRecipes, id: \.uuid) { recipe in
            NavigationLink(destination: RecipeDetailsView(recipe: recipe)) {
                recipeRow(recipe: recipe)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        showFavoritesOnly.toggle()
                    }
                } label: {
                    Image(systemName: showFavoritesOnly ? "star.fill" : "star")
                        .font(.system(size: 18))
                        .foregroundStyle(showFavoritesOnly ? .yellow : .gray)
                }
            }
        }
    }
}
