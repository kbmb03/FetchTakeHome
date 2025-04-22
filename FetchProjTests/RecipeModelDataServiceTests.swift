//
//  RecipeModelDataServiceTests.swift
//  FetchProjTests
//
//  Created by Kaleb Davis on 4/21/25.
//

import Foundation
import XCTest
@testable import FetchProj

final class RecipeModelDataServiceTests: XCTestCase {
    var recipeModelDataService: RecipeModelDataService!
    
    override func setUp() {
        super.setUp()
        recipeModelDataService = RecipeModelDataService.instance
    }
    
    override func tearDown() {
        RecipeStorageManager.instance.removeAllData()
        recipeModelDataService = nil
        super.tearDown()
    }
    
    func testDownloadDataSuccess() async throws {
        let recipes = try await recipeModelDataService.downloadData()
        
        XCTAssertFalse(recipes.isEmpty)
        XCTAssertNotNil(recipes.first?.uuid)
        XCTAssertNotNil(recipes.first?.cuisine)
        XCTAssertNotNil(recipes.first?.name)
    }
    
    func testEmptyEndpoint() async throws {
        let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        let recipes = try await recipeModelDataService.downloadData(from: endpoint)
        XCTAssertTrue(recipes.isEmpty, "for empty data, recipes array should be empty")
    }
    
    func testMalformedEndpoint() async throws {
        let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        
        do {
            _ = try await recipeModelDataService.downloadData(from: endpoint)
            XCTFail("malformed data should trigger error to be thrown")
        } catch {
            XCTAssertTrue(String(describing: error) == String(describing: RecipeError.invalidData), "Should throw an invalidData error")
        }
    }
    
    func testInvalidURL() async {
        do {
            _ = try await recipeModelDataService.downloadData(from: "")
            XCTFail("Should throw an error for invalid URL")
        } catch {
            XCTAssertTrue(String(describing: error) == String(describing: RecipeError.invalidURL), "Should throw an invalidURL error")
        }
    }
    
    func testDataIsSavedAfterDownload() async throws {
        let recipes = try await recipeModelDataService.downloadData()
        
        let cachedRecipes = RecipeStorageManager.instance.loadRecipes()
        
        XCTAssertNotNil(cachedRecipes)
        XCTAssertEqual(recipes.count, cachedRecipes?.count)
        XCTAssertEqual(recipes.first?.uuid, cachedRecipes?.first?.uuid)
    }
    
    func testUsesSavedDataOnDownloadFail() async throws {
        let recipes = try await recipeModelDataService.downloadData()
        
        do {
            let badRecipes = try await recipeModelDataService.downloadData(from: " ")
            XCTAssertEqual(badRecipes.count, recipes.count)
        } catch {
            XCTFail("shouldnt throw error when using saved recipes")
        }
    }
}
