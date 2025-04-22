import XCTest
@testable import FetchProj

final class RecipeStorageManagerTests: XCTestCase {
    var sut: RecipeStorageManager!
    
    override func setUp() {
        super.setUp()
        sut = RecipeStorageManager.instance
    }
    
    override func tearDown() {
        sut.removeAllData()  // Clean up after each test
        sut = nil
        super.tearDown()
    }
    
    func testSaveAndLoadRecipes() {
        // Given
        let testRecipes = [
            Recipe(cuisine: "cuisine1",
                   name: "Test Recipe 1",
                   photoUrlLarge: "https://test.com/large1.jpg",
                   photoUrlSmall: "https://test.com/small1.jpg",
                   uuid: "uuid1",
                  sourceUrl: "https://test.com/source1",
                  youtubeUrl: "https://youtube.com/test1")
        ]
        
        // When
        sut.saveRecipes(recipes: testRecipes)
        let loadedRecipes = sut.loadRecipes()
        
        // Then
        XCTAssertNotNil(loadedRecipes)
        XCTAssertEqual(loadedRecipes?.count, 1)
        XCTAssertEqual(loadedRecipes?.first?.name, "Test Recipe 1")
        XCTAssertEqual(loadedRecipes?.first?.uuid, "uuid1")
    }
    
    func testRemoveAllData() {
        // Given
        let testRecipe = Recipe(cuisine: "test-cuisine",
                                name: "Test Recipe",
                                photoUrlLarge: "https://test.com/large.jpg",
                                photoUrlSmall: "https://test.com/small.jpg",
                                uuid: "uuid",
                              sourceUrl: "https://test.com/source",
                              youtubeUrl: "https://youtube.com/test")
        sut.saveRecipes(recipes: [testRecipe])
        
        // When
        sut.removeAllData()
        let loadedRecipes = sut.loadRecipes()
        
        // Then
        XCTAssertNil(loadedRecipes)
    }
    
    func testLoadRecipesWhenNoDataExists() {
        // Given
        sut.removeAllData()
        
        // When
        let loadedRecipes = sut.loadRecipes()
        
        // Then
        XCTAssertNil(loadedRecipes)
    }
} 
