//
//  RecipeDetailsView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/17/25.
//

import SwiftUI

struct RecipeDetailsView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let photoUrl = recipe.photoUrlLarge {
                    ImageView(url: photoUrl, key: "\(recipe.uuid)_large", isCircle: false)
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .clipped()
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    // Recipe Name
                    Text(recipe.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    // Cuisine Type
                    HStack {
                        Image(systemName: "fork.knife")
                            .foregroundColor(.gray)
                        Text(recipe.cuisine)
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    
                    // Links Section
                    VStack(alignment: .leading, spacing: 12) {
                        if let sourceUrl = recipe.sourceUrl {
                            Link(destination: URL(string: sourceUrl)!) {
                                HStack {
                                    Image(systemName: "book.fill")
                                    Text("View Recipe Source")
                                }
                            }
                        }
                        
                        if let youtubeUrl = recipe.youtubeUrl {
                            Link(destination: URL(string: youtubeUrl)!) {
                                HStack {
                                    Image(systemName: "play.rectangle.fill")
                                        .foregroundColor(.red)
                                    Text("Watch on YouTube")
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
