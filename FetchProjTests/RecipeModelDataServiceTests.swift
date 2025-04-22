import XCTest
@testable import FetchProj

final class RecipeModelDataServiceTests: XCTestCase {
    var sut: RecipeModelDataService!
    
    override func setUp() {
        super.setUp()
        sut = RecipeModelDataService.instance
    }
    
    override func tearDown() {
        RecipeStorageManager.instance.removeAllData()
        sut = nil
        super.tearDown()
    }
    
    func testDownloadDataSuccess() async throws {
        // When
        let recipes = try await sut.downloadData()
        
        // Then
        XCTAssertFalse(recipes.isEmpty)
        XCTAssertNotNil(recipes.first?.uuid)
        XCTAssertNotNil(recipes.first?.name)
    }
    
    func testDataIsCachedAfterDownload() async throws {
        // Given
        let recipes = try await sut.downloadData()
        
        // When
        let cachedRecipes = RecipeStorageManager.instance.loadRecipes()
        
        // Then
        XCTAssertNotNil(cachedRecipes)
        XCTAssertEqual(recipes.count, cachedRecipes?.count)
        XCTAssertEqual(recipes.first?.uuid, cachedRecipes?.first?.uuid)
    }
} 
