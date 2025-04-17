//
//  DownloadingImagesViewModel.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation
import Combine

@MainActor
class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [Recipe] = []
    let dataService = RecipeModelDataService.instance
    
    init() {
        Task {
            await downloadData()
        }
    }
    
    func downloadData() async {
        
        do {
            let recipes = try await dataService.downloadData()
            //downloadData sets dataService value, set self.dataArray to it or make it return something.
            self.dataArray = recipes
        } catch {
            print("failed to download data: \(error)")
        }
        
//        dataService.$recipeModels
//            .sink { [weak self] (returnedRecipeModels) in
//                self?.dataArray = returnedRecipeModels
//                print(self?.dataArray ?? "")
//            }
//            .store(in: &cancellables)
    }
    
}
