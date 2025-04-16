//
//  DownloadingImagesViewModel.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [Recipe] = []
    var cancellables = Set<AnyCancellable>()
    let dataService = RecipeModelDataService.instance
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$recipeModels
            .sink { [weak self] (returnedRecipeModels) in
                self?.dataArray = returnedRecipeModels
                print(self?.dataArray ?? "")
            }
            .store(in: &cancellables)
    }
    
}
