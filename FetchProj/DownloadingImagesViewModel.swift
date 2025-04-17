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
    @Published var error: recipeError?
    
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
            self.error = nil
            //if case for recipeError, then set it, otherwise set error as other
        } catch let error as recipeError {
            print("failed to download data: \(error)")
            self.error = error
        } catch {
            self.error = .other(error)
        }
    }
    
}
