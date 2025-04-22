//
//  ImageView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import SwiftUI

struct ImageView: View {
    @StateObject var loader: ImageLoadingViewModel
        
    init(url: String, key: String) {
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            }
        }
    }
}
