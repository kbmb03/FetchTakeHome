//
//  DownloadingRecipeImagesView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import SwiftUI

struct DownloadingRecipeImagesView: View {
    @StateObject var vm = DownloadingImagesViewModel()
    
    @ViewBuilder
    var mainContent: some View {
        if let error = vm.error {
            ErrorView(errorMessage: error.errorMessage)
        } else if vm.dataArray.isEmpty {
            EmptyDataView()
        } else {
            RecipeListView(recipes: vm.dataArray)
        }
    }
    
    var body: some View {
        NavigationStack {
            mainContent
                .navigationTitle("Recipes")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            Task {
                                RecipeModelFileManager.instance.removeAllImages()
                                RecipeDataFileManager.instance.removeAllData()
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

