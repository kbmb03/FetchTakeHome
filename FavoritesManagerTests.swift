import XCTest
@testable import FetchProj

final class FavoritesManagerTests: XCTestCase {
    var sut: FavoritesManager!  // system under test
    
    override func setUp() {
        super.setUp()
        sut = FavoritesManager.shared
        // Clear favorites before each test
        UserDefaults.standard.removeObject(forKey: "Favorites")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAddFavorite() {
        // Given
        let recipe = Recipe(uuid: "123", name: "Test Recipe", cuisine: "Italian", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil)
        
        // When
        sut.add(recipe)
        
        // Then
        XCTAssertTrue(sut.contains(recipe))
    }
    
    func testRemoveFavorite() {
        // Given
        let recipe = Recipe(uuid: "123", name: "Test Recipe", cuisine: "Italian", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil)
        sut.add(recipe)
        
        // When
        sut.remove(recipe)
        
        // Then
        XCTAssertFalse(sut.contains(recipe))
    }
    
    func testToggleFavorite() {
        // Given
        let recipe = Recipe(uuid: "123", name: "Test Recipe", cuisine: "Italian", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil)
        
        // When - Toggle on
        sut.toggle(recipe)
        
        // Then
        XCTAssertTrue(sut.contains(recipe))
        
        // When - Toggle off
        sut.toggle(recipe)
        
        // Then
        XCTAssertFalse(sut.contains(recipe))
    }
    
    func testFavoritesPersistence() {
        // Given
        let recipe = Recipe(uuid: "123", name: "Test Recipe", cuisine: "Italian", photoUrlLarge: nil, photoUrlSmall: nil, sourceUrl: nil, youtubeUrl: nil)
        
        // When
        sut.add(recipe)
        
        // Then
        let newManager = FavoritesManager.shared
        XCTAssertTrue(newManager.contains(recipe))
    }
} 