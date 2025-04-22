//
//  RecipeContainerView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import SwiftUI

struct RecipeContainerView: View {
    @StateObject var vm = RecipeListViewModel()
    
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
                                RecipeStorageManager.instance.removeAllData()
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
    RecipeContainerView()
}

