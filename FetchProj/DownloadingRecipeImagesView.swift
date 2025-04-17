//
//  DownloadingRecipeImagesView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import SwiftUI

struct DownloadingRecipeImagesView: View {
    @StateObject var vm = DownloadingImagesViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if let error = vm.error {
                    VStack {
                        Spacer()
                        Text(error.errorMessage)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    }
                } else if vm.dataArray.isEmpty {
                    VStack {
                        Spacer()
                        Text("Sorry, but no recipes are currently available. Please refresh or check again later.")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(vm.dataArray, id: \.uuid) { model in
                            recipeRow(recipe: model)
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task {
                            // Clear both image and recipe caches
                            RecipeModelFileManager.instance.removeAllImages()
                            RecipeDataFileManager.instance.removeAllData()
                            // Refresh data
                            await vm.downloadData()
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
        .task {
            await vm.downloadData()
        }
    }
}

#Preview {
    DownloadingRecipeImagesView()
}

