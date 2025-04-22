//
//  RecipeErrors.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/17/25.
//

import Foundation

enum recipeError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case other(Error)
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "Sorry, there was a problem with the URL"
        case .invalidResponse:
            return "Sorry, we have received an invalid response from the server"
        case .invalidData:
            return "Sorry, there was a problem with the data, please refresh or try again later"
        case .other(let error):
            return "Sorry, an unexpected error occured: \(error.localizedDescription)"
        }
    }
}

