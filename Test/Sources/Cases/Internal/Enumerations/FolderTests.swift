import Testing

@testable import ColibriLibrary

struct FolderTests {
    
    // MARK: Properties tests

    @Test(arguments: zip(Folder.allCasesWithRoot, Expectation.paths))
    func paths(for folder: Folder, expects path: String) async throws {
        // GIVEN
        // WHEN
        let result = folder.path
        
        // THEN
        #expect(result == path)
    }

}

// MARK: - Expectations

private extension FolderTests {
    enum Expectation {
        static let paths: [String] = [
            "",
            "App/Sources/",
            "Library/Sources/Public/",
            "Library/Sources/Internal/",
            "Test/Sources/Cases/Public/",
            "Test/Sources/Cases/Internal/",
            "Test/Sources/Helpers/"
        ]
    }
}
