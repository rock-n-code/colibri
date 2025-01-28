import Testing

@testable import ColibriLibrary

struct FileTests {
    
    // MARK: Properties tests
    
    @Test(arguments: zip(File.allCases, Expectation.fileNames))
    func fileName(for file: File, expects fileName: String) async throws {
        // GIVEN
        // WHEN
        let result = file.fileName
        
        // THEN
        #expect(result == fileName)
    }
    
    @Test(arguments: zip(File.allCases, Expectation.filePaths))
    func filePath(for file: File, expects filePath: String) async throws {
        // GIVEN
        // WHEN
        let result = file.filePath
        
        // THEN
        #expect(result == filePath)
    }
    
    @Test(arguments: zip(File.allCases, Expectation.folders))
    func folder(for file: File, expects folder: Folder) async throws {
        // GIVEN
        // WHEN
        let result = file.folder
        
        // THEN
        #expect(result == folder)
    }

    @Test(arguments: zip(File.allCases, Expectation.resourcePaths))
    func resourcePath(for file: File, expects resourcePath: String) async throws {
        // GIVEN
        // WHEN
        let result = file.resourcePath
        
        // THEN
        #expect(result == resourcePath)
    }
    
}

// MARK: - Expectations

private extension FileTests {
    enum Expectation {
        static let fileNames: [String] = [
            "App.swift",
            "AppArguments.swift",
            "AppBuilder.swift",
            "AppOptions.swift",
            "AppTests.swift",
            "Dockerfile",
            ".dockerignore",
            "Environment+Properties.swift",
            ".gitignore",
            "LICENSE",
            "LoggerLevel+Conformances.swift",
            "Package.swift",
            "README.md",
            "TestArguments.swift"
        ]

        static let filePaths: [String] = [
            "App/Sources/App.swift",
            "Library/Sources/Public/AppArguments.swift",
            "Library/Sources/Public/AppBuilder.swift",
            "App/Sources/AppOptions.swift",
            "Test/Sources/Cases/Public/AppTests.swift",
            "Dockerfile",
            ".dockerignore",
            "Library/Sources/Internal/Environment+Properties.swift",
            ".gitignore",
            "LICENSE",
            "Library/Sources/Internal/LoggerLevel+Conformances.swift",
            "Package.swift",
            "README.md",
            "Test/Sources/Helpers/TestArguments.swift"
        ]
        
        static let folders: [Folder] = [
            .app,
            .libraryPublic,
            .libraryPublic,
            .app,
            .testCasesPublic,
            .root,
            .root,
            .libraryInternal,
            .root,
            .root,
            .libraryInternal,
            .root,
            .root,
            .testHelpers
        ]
            

        static let resourcePaths: [String] = [
            "Resources/Files/Sources/App",
            "Resources/Files/Sources/Library",
            "Resources/Files/Sources/Library",
            "Resources/Files/Sources/App",
            "Resources/Files/Sources/Test",
            "Resources/Files/Sources",
            "Resources/Files/Sources",
            "Resources/Files/Sources/Library",
            "Resources/Files/Sources",
            "Resources/Files/Sources",
            "Resources/Files/Sources/Library",
            "Resources/Files/Sources",
            "Resources/Files/Sources",
            "Resources/Files/Sources/Test"
        ]
    }
}

