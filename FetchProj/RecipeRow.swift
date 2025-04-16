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
    
    var body: some View {
        
        HStack {
            ImageView(url: recipe.photoUrlSmall ?? "", key: recipe.uuid)
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    recipeRow(recipe: Recipe(cuisine: "American", name: "Burger", photoUrlLarge: nil, photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", uuid: "ABC", sourceUrl: nil, youtubeUrl: nil))
}

