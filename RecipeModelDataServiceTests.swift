final class RecipeModelDataServiceTests: XCTestCase {
    var sut: RecipeModelDataService!
    
    override func setUp() {
        super.setUp()
        sut = RecipeModelDataService.instance
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDownloadData() async throws {
        // When
        let recipes = try await sut.downloadData()
        
        // Then
        XCTAssertFalse(recipes.isEmpty)
        XCTAssertNotNil(recipes.first?.name)
        XCTAssertNotNil(recipes.first?.cuisine)
    }
    
    func testInvalidURLError() async {
        // Given
        // Modify endpoint to be invalid
        
        // When/Then
        do {
            _ = try await sut.downloadData()
            XCTFail("Expected error not thrown")
        } catch {
            XCTAssertTrue(error is recipeError)
        }
    }
} 