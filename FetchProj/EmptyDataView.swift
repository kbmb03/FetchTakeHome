//
//  EmptyDataView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/17/25.
//

import SwiftUI

struct EmptyDataView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Sorry, but no recipes are currently available. Please refresh or check again later.")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    EmptyDataView()
}
