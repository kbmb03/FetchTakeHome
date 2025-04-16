//
//  RecipeModelCacheManager.swift
//  FetchProj
//
//  Created by Kaleb Davis on 4/15/25.
//

import Foundation
import SwiftUI

class RecipeModelCacheManager {
    
    static let instance = RecipeModelCacheManager()
    private init() { }
    
    var recipeCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 150
        cache.totalCostLimit = 1024 * 1024 * 200
        return cache
    }()
    
    func add(key: String, value: UIImage) {
        recipeCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return recipeCache.object(forKey: key as NSString)
    }
}
