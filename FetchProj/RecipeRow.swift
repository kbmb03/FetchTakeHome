//
//  RecipeRow.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation
import SwiftUI

struct recipeRow: View {
    let recipe: Recipe
    @State private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        
        HStack {
            ImageView(url: recipe.photoUrlSmall ?? "", key: recipe.uuid)
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                HStack {
                    Text(recipe.name)
                        .font(.headline)
                    if favoritesManager.contains(recipe) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.subheadline)
                    }
                }

                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
