//
//  ImageView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import SwiftUI

struct ImageView: View {
    @StateObject var loader: ImageLoadingViewModel
    var isCircular: Bool = true
        
    init(url: String, key: String, isCircle: Bool = true) {
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
        self.isCircular = isCircle
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    //.clipShape(isCircular ? Circle() : Rectangle())
            }
        }
    }
}

#Preview {
    ImageView(url: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", key: "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
        .frame(width: 75, height: 75)
}
