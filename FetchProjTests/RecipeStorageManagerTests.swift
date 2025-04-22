//
//  RecipeStorageManagerTests.swift
//  FetchProjTests
//
//  Created by Kaleb Davis on 4/21/25.
//

import Foundation
import XCTest
@testable import FetchProj

final class RecipeStorageManagerTests: XCTestCase {
    var recipeStorageManager: RecipeStorageManager!
    
    let mockRecipe1 = Recipe(cuisine: "cuisine1", name: "name1", photoUrlLarge: "largePhotoURL1", photoUrlSmall: "smallPhotoURL1", uuid: "uuid1", sourceUrl: "sourceURL1", youtubeUrl: "youtubeURL1")
    
    let mockRecipe2 = Recipe(cuisine: "cuisine2", name: "name2", photoUrlLarge: "largePhotoURL12", photoUrlSmall: "smallPhotoURL2", uuid: "uuid2", sourceUrl: "sourceURL2", youtubeUrl: "youtubeURL2")
    
    override func setUp() {
        super.setUp()
        recipeStorageManager = RecipeStorageManager.instance
    }
    
    override func tearDown() {
        recipeStorageManager.removeAllData()
        super.tearDown()
    }
    
    func testSaveAndLoadRecipes() {
        let recipes = [mockRecipe1]
        
        recipeStorageManager.saveRecipes(recipes: recipes)
        let loadedRecipes = recipeStorageManager.loadRecipes()
        
        XCTAssertNotNil(loadedRecipes)
        XCTAssertEqual(loadedRecipes?.count, 1)
        XCTAssertEqual(loadedRecipes?.first?.name, "name1")
        XCTAssertEqual(loadedRecipes?.first?.cuisine, "cuisine1")
        XCTAssertEqual(loadedRecipes?.first?.uuid, "uuid1")
    }
    
    func testLoadRecipesWhenEmpty() {
        recipeStorageManager.removeAllData()
        let loadedRecipes = recipeStorageManager.loadRecipes()
        XCTAssertNil(loadedRecipes, "Should return nil when no recipes are saved")
    }
    
    func testSaveMultipleRecipes() {
        let recipes = [mockRecipe1, mockRecipe2]
        
        recipeStorageManager.saveRecipes(recipes: recipes)
        let loadedRecipes = recipeStorageManager.loadRecipes()
        
        XCTAssertEqual(loadedRecipes?.count, 2)
        XCTAssertTrue(loadedRecipes?.contains(where: { $0.name == "name2" }) ?? false)
        XCTAssertTrue(loadedRecipes?.contains(where: { $0.name == "name1" }) ?? false)
    }
    
    func testOverwriteExistingRecipes() {
        recipeStorageManager.saveRecipes(recipes: [mockRecipe1])
        
        recipeStorageManager.saveRecipes(recipes: [mockRecipe2])
        let loadedRecipes = recipeStorageManager.loadRecipes()
        
        XCTAssertEqual(loadedRecipes?.count, 1)
        XCTAssertEqual(loadedRecipes?.first?.name, "name2")
        XCTAssertFalse(loadedRecipes?.contains(where: { $0.name == "name1" }) ?? true)
    }
    
    func testSaveEmptyArray() {
        recipeStorageManager.saveRecipes(recipes: [])
        let loadedRecipes = recipeStorageManager.loadRecipes()
        
        XCTAssertNotNil(loadedRecipes)
        XCTAssertEqual(loadedRecipes?.count, 0)
    }
    
    func testRemoveAllData() {
        recipeStorageManager.saveRecipes(recipes: [mockRecipe1, mockRecipe2])
        
        recipeStorageManager.removeAllData()
        let loadedRecipes = recipeStorageManager.loadRecipes()
        
        XCTAssertNil(loadedRecipes)
    }
        
    func testPersistenceBetweenInstances() {
        recipeStorageManager.saveRecipes(recipes: [mockRecipe1])
        
        let newManager = RecipeStorageManager.instance
        let loadedRecipes = newManager.loadRecipes()
        
        XCTAssertNotNil(loadedRecipes)
        XCTAssertEqual(loadedRecipes?.first?.name, "name1")
    }
}
