//
//  ImageLoadingViewModel.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation
import SwiftUI
import os

@MainActor
class ImageLoadingViewModel: ObservableObject {
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: ImageLoadingViewModel.self))
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    let manager = RecipeModelFileManager.instance
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        Task {
            await getImage()
        }
    }
    
    func getImage() async {
        if let savedImage = await manager.get(key: imageKey) {
            image = savedImage
        } else {
            await downloadImage()
        }
    }
    
    func downloadImage() async {
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        do {
            
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw recipeError.invalidResponse
            }
            
            if let downloadedImage = UIImage(data: data) {
                self.image = downloadedImage
                await manager.add(key: self.imageKey, value: downloadedImage)
            } else {
                Self.logger.error("failed to save image")
            }
        } catch {
            Self.logger.error("Error downloading image \(error)")
        }
        isLoading = false
        
    }
}
