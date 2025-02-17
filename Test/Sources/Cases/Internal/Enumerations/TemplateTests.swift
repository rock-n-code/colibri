import Testing

@testable import ColibriLibrary

struct TemplateTests {
    
    // MARK: Properties tests
    
    @Test(arguments: zip(Template.allCases, Expectation.fileNames))
    func fileName(for template: Template, expects fileName: String) async throws {
        // GIVEN
        // WHEN
        let result = template.fileName
        
        // THEN
        #expect(result == fileName)
    }
    
    @Test(arguments: zip(Template.allCases, Expectation.filePaths))
    func filePath(for template: Template, expects filePath: String) async throws {
        // GIVEN
        // WHEN
        let result = template.filePath
        
        // THEN
        #expect(result == filePath)
    }
    
    @Test(arguments: zip(Template.allCases, Expectation.folders))
    func folder(for template: Template, expects folder: Folder) async throws {
        // GIVEN
        // WHEN
        let result = template.folder
        
        // THEN
        #expect(result == folder)
    }
    
}

// MARK: - Expectations

private extension TemplateTests {
    enum Expectation {
        static let fileNames: [String] = [
            "App.swift",
            "AppTests.swift",
            "Package.swift",
        ]
        
        static let filePaths: [String] = [
            "App/Sources/App.swift",
            "Test/Sources/Cases/Public/AppTests.swift",
            "Package.swift",
        ]
        
        static let folders: [Folder] = [
            .app,
            .testCasesPublic,
            .root,
        ]
    }
}
