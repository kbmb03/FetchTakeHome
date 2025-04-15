//
//  RecipeRow.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation
import SwiftUI

struct recipeRow: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.photoUrlSmall ?? "")) {
                image in image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Circle()
                    .foregroundStyle(.secondary)
            }
            .frame(width: 80, height: 80)
            Text(recipe.name)
                .font(.title)
            Spacer()
        }
    }
}
