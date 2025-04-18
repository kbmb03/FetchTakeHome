//
//  RecipeDetailsView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/17/25.
//

import SwiftUI

struct RecipeDetailsView: View {
    let recipe: Recipe
    @State private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                if let photoUrl = recipe.photoUrlLarge {
                    ImageView(url: photoUrl, key: "\(recipe.uuid)_large")
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .clipped()
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    // Header Section
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(recipe.name)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button {
                                favoritesManager.toggle(recipe)
                            } label: {
                                Image(systemName: favoritesManager.contains(recipe) ? "star.fill" : "star")
                                    .font(.system(size: 35))
                                    .foregroundStyle(favoritesManager.contains(recipe) ? .yellow : .gray)
                            }
                        }
                        
                        HStack {
                            Label(recipe.cuisine, systemImage: "fork.knife")
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        if let urlStr = recipe.sourceUrl,
                           let url = URL(string: urlStr) {
                            Link(destination: url) {
                                HStack {
                                    Image(systemName: "book.fill")
                                        .foregroundStyle(.blue)
                                    Text("View Recipe")
                                        .foregroundStyle(.primary)
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                        }
                        
                        if let urlStr = recipe.youtubeUrl,
                           let url = URL(string: urlStr) {
                            Link(destination: url) {
                                HStack {
                                    Image(systemName: "play.rectangle.fill")
                                        .foregroundStyle(.red)
                                    Text("Watch Video Tutorial")
                                        .foregroundStyle(.primary)
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}
