//
//  ErrorView.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/17/25.
//

import SwiftUI

struct ErrorView: View {
    
    let errorMessage: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(errorMessage)
                .font(.subheadline)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}
