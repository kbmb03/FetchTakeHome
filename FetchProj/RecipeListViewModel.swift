//
//  RecipeListViewModel.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation
import os

@MainActor
class RecipeListViewModel: ObservableObject {
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: RecipeListViewModel.self))
    
    @Published var dataArray: [Recipe] = []
    @Published var error: RecipeError?
    
    let dataService = RecipeModelDataService.instance
    
    init() {
        Task {
            await downloadData()
        }
    }
    
    func downloadData() async {
        do {
            let recipes = try await dataService.downloadData()
            self.dataArray = recipes
            self.error = nil
        } catch let error as RecipeError {
            Self.logger.error("Failed to download data: \(error)")
            self.error = error
        } catch {
            Self.logger.error("Failed to download data: \(error)")
            self.error = .other(error)
        }
    }
    
}
