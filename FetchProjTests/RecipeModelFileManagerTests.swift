//
//  RecipeModelFileManagerTests.swift
//  FetchProjTests
//
//  Created by Kaleb Davis on 4/21/25.
//

import Foundation
import XCTest
@testable import FetchProj

final class RecipeModelFileManagerTests: XCTestCase {
    var recipeModelFileManager: RecipeModelFileManager!
    let testImage = UIImage(systemName: "star.fill")!
    
    override func setUp() {
        super.setUp()
        recipeModelFileManager = RecipeModelFileManager.instance
    }
    
    override func tearDown() {
        recipeModelFileManager.removeAllImages()
        super.tearDown()
    }
    
    func testSaveAndGetImage() async {
        let key = "testImage"
        
        await recipeModelFileManager.add(key: key, value: testImage)
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        let retrievedImage = await recipeModelFileManager.get(key: key)
        
        XCTAssertNotNil(retrievedImage, "Should retrieve saved image")
    }
    
    func testGetFakeImage() async {
        let retrievedImage = await recipeModelFileManager.get(key: "Fake")
        XCTAssertNil(retrievedImage, "Should return nil for nonexistent image")
    }
    
    func testRemoveAllImages() async {
        let keys = ["key1", "key2", "key3"]
        
        for key in keys {
            await recipeModelFileManager.add(key: key, value: testImage)
        }
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        recipeModelFileManager.removeAllImages()
        
        for key in keys {
            let retrievedImage = await recipeModelFileManager.get(key: key)
            XCTAssertNil(retrievedImage, "Image should have been removed")
        }
    }
    
    func testAddMultipleImages() async {
        let keys = ["test1", "test2", "test3"]
        
        for key in keys {
            await recipeModelFileManager.add(key: key, value: testImage)
        }
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        for key in keys {
            let retrievedImage = await recipeModelFileManager.get(key: key)
            XCTAssertNotNil(retrievedImage, "Should retrieve saved image: \(key)")
        }
    }
    
    func testFolderCreation() {
        let fileManager = FileManager.default
        let folderName = "downloaded_photos"
        
        if let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let folderURL = cachesDirectory.appendingPathComponent(folderName)
            XCTAssertTrue(fileManager.fileExists(atPath: folderURL.path), "Folder should exist")
        }
    }
}
