//
//  ImageLoadingViewModel.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    let manager = RecipeModelFileManager.instance
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("gets saved image")
        } else {
            downloadImage()
            print("Downloading Images")
        }
    }
    
    func downloadImage() {
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            print("A")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                guard let self = self,
                      let image = returnedImage else {
                    return
                }
                self.image = returnedImage
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
    }
}
