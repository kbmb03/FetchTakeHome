//
//  RecipeView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation
import SwiftUI

struct RecipeView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()
                
                Text("Cuisine: \(recipe.cuisine)")
                    .font(.title3)
                
                if let photoUrlLarge = recipe.photoUrlLarge, let url = URL(string: photoUrlLarge) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                }
                
                if let sourceUrl = recipe.sourceUrl, let url = URL(string: sourceUrl) {
                    Link("View Recipe", destination: url)
                        .font(.title3)
                        .foregroundColor(.blue)
                }
                
                if let youtubeUrl = recipe.youtubeUrl, let url = URL(string: youtubeUrl) {
                    Link("Watch on YouTube", destination: url)
                        .font(.title3)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
}
