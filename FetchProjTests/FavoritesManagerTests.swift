//
//  FavoritesManagerTests.swift
//  FetchProjTests
//
//  Created by Kaleb Davis on 4/21/25.
//

import Foundation
import XCTest
@testable import FetchProj

final class FavoritesManagerTests: XCTestCase {
    var favoritesManager: FavoritesManager!  // system under test
    let key = "Favorites"
    let mockRecipe = Recipe(cuisine: "testCuisine1", name: "testName1", photoUrlLarge: nil, photoUrlSmall: nil, uuid: "testUUID", sourceUrl: nil, youtubeUrl: nil)
    let mockRecipe2 = Recipe(cuisine: "testCuisine2", name: "testName2", photoUrlLarge: nil, photoUrlSmall: nil, uuid: "testUUID2", sourceUrl: nil, youtubeUrl: nil)
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
        favoritesManager = FavoritesManager.shared
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
        favoritesManager = nil
        super.tearDown()
    }
    
    func testAddFavorite() {
        favoritesManager.add(mockRecipe)
        XCTAssertTrue(favoritesManager.contains(mockRecipe), "MockRecipe should have been added to favorites")
        XCTAssertTrue(favoritesManager.favoriteRecipeIDs.contains(mockRecipe.uuid), "MockRecipe should have been added to favoriteRecipeIDs")
    }
    
    func testRemoveFavorite() {
        favoritesManager.add(mockRecipe)
        XCTAssertTrue(favoritesManager.contains(mockRecipe), "Recipe should have been added to favorites")
        
        favoritesManager.remove(mockRecipe)
        
        XCTAssertFalse(favoritesManager.contains(mockRecipe), "Recipe should no longer be in favorites")
        XCTAssertFalse(favoritesManager.favoriteRecipeIDs.contains(mockRecipe.uuid), "Recipe UUID should no longer be in favoriteRecipeIDs")
    }
    
    func testToggleFavorite() {
        favoritesManager.toggle(mockRecipe)
        
        XCTAssertTrue(favoritesManager.contains(mockRecipe), "Recipe should be in favorites after toggle")
               
        favoritesManager.toggle(mockRecipe)
       XCTAssertFalse(favoritesManager.contains(mockRecipe), "Recipe should not be favorite after this toggle")
    }
    
    func testFavoritesPersistence() {
        favoritesManager.add(mockRecipe)
        let newManager = FavoritesManager.shared
        
        XCTAssertTrue(newManager.contains(mockRecipe), "Favorites should persist across instances")
    }
    
    func testAddMultipleRecipes() {
        favoritesManager.add(mockRecipe)
        favoritesManager.add(mockRecipe2)
        
        XCTAssertTrue(favoritesManager.contains(mockRecipe), "First recipe should be in favorites")
        XCTAssertTrue(favoritesManager.contains(mockRecipe2), "Second recipe should be in favorites")
        XCTAssertEqual(favoritesManager.favoriteRecipeIDs.count, 2, "There should be 2 favorites")
    }
    
    func testAddingDuplicate() {
        favoritesManager.add(mockRecipe)
        favoritesManager.add(mockRecipe)
        
        XCTAssertEqual(favoritesManager.favoriteRecipeIDs.count, 1, "Duplicate recipes should not be added")
    }
    
    func testRemovingNonExistent() {
        XCTAssertFalse(favoritesManager.contains(mockRecipe), "Recipe should not be in favorites after init")
        
        favoritesManager.remove(mockRecipe)
        XCTAssertFalse(favoritesManager.contains(mockRecipe), "Recipe should still not be in favorites")
    }
}
