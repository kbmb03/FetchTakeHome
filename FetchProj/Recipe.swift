//
//  Recipe.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation

struct Recipe: Decodable {
    let cuisine : String
    let name : String
    let photoUrlLarge : String?
    let photoUrlSmall : String?
    let uuid : String
    let sourceUrl : String?
    let youtubeUrl : String?

}

struct RecipeWrapper: Decodable {
    let recipes: [Recipe]
}
