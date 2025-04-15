//
//  ContentView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/14/25.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var recipes: [Recipe] = []
    
    var body: some View {
        NavigationSplitView {
                List(recipes, id: \.uuid) { recipe in
                    NavigationLink { RecipeView(recipe: recipe)
                    } label: {
                        recipeRow(recipe: recipe)
                    }
                }
                .navigationTitle("Recipes")
            .task {
                await loadRecipes()
            }
        } detail: {
            Text("Select a recipe")
        }
    }

    // Function to load recipes asynchronously
    private func loadRecipes() async {
        do {
            recipes = try await getRecipe()
        } catch recipeError.invalidData {
            print("Invalid data")
        } catch recipeError.invalidResponse {
            print("Invalid response")
        } catch recipeError.invalidURL {
            print("Invalid URL")
        } catch {
            print("other error")
        }
    }
}

#Preview {
    ContentView()
}

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



#Preview {
    ContentView()
}

func getRecipe() async throws -> [Recipe] {
    //put in viewModel
    let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    guard let url = URL(string: endpoint) else {
        throw recipeError.invalidURL
    }
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw recipeError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedRecipes = try decoder.decode(RecipeWrapper.self, from: data)
        return decodedRecipes.recipes
        //error log invalid recipes??
    } catch {
        throw recipeError.invalidData
    }
}

struct Recipe: Decodable {
    let cuisine : String
    let name : String
    let photoUrlLarge : String?
    let photoUrlSmall : String?
    let uuid : String
    let sourceUrl : String?
    let youtubeUrl : String?
    
}

struct RecipeWrapper: Decodable {
    let recipes: [Recipe]
}

enum recipeError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct recipeRow: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            Text(recipe.name)
            
            Spacer()
        }
    }
}
