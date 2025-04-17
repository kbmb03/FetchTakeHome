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
        NavigationView {
            List {
                ForEach(vm.dataArray, id: \.uuid) { model in
                    recipeRow(recipe: model)
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("refresh")
                    }) {
                        Image(systemName: "arror.clockwise")
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

