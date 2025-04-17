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
            List {
                ForEach(vm.dataArray, id: \.uuid) { model in
                    recipeRow(recipe: model)
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

