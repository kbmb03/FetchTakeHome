//
//  EmptyFavoritesView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/18/25.
//

import SwiftUI

struct EmptyFavoritesView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("No Favorites Yet")
                .font(.title2)
                .fontWeight(.medium)
                .padding()
            Text("Your favorite recipes will appear here")
                .foregroundStyle(.secondary)
            Spacer()
        }
    }
}

#Preview {
    EmptyFavoritesView()
}
