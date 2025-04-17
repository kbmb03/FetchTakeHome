//
//  RecipeListView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/17/25.
//

import SwiftUI

struct RecipeListView: View {
    let recipes: [Recipe]
    
    var body: some View {
        List {
            ForEach(recipes, id: \.uuid) { recipe in
                NavigationLink(destination: RecipeDetailsView(recipe: recipe)) {
                    recipeRow(recipe: recipe)
                }
            }
        }
    }
}
