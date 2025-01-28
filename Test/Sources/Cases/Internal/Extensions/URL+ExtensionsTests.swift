import Foundation
import Testing

@testable import ColibriLibrary

struct URL_ExtensionsTests {
    
    // MARK: Initialisers tests

    @Test(arguments: zip([String.someFilePath, .dotPath, .tildePath],
                         [URL.someFile, .dotFile, .tildeFile]))
    func initAt(
        with filePath: String,
        expects url: URL
    ) async throws {
        // GIVEN
        // WHEN
        let result = URL(at: filePath)

        // THEN
        #expect(result == url)
        #expect(result.isFileURL == true)
    }

    // MARK: Computed tests
    
    @Test(arguments: zip([URL.someFile, .dotFile, .tildeFile, .someURL],
                         [String.someFilePath, .dotPath, .tildePath, .empty]))
    func pathString(
        with url: URL,
        expects path: String
    ) async throws {
        // GIVEN
        // WHEN
        let result = url.pathString
        
        // THEN
        #expect(result == path)
    }
    
    // MARK: Functions tests
    
    @Test(arguments: zip([URL.dotFile, .tildeFile, .someFile],
                       [".\(String.someFilePath)", "~\(String.someFilePath)", "\(String.someFilePath)\(String.someFilePath)"]))
    func appendingPath(
        with url: URL,
        expects path: String
    ) async throws {
        // GIVEN
        // WHEN
        let result = url.appendingPath(.someFilePath)
        
        // THEN
        #expect(result.pathString == path)
        #expect(result.isFileURL == true)
    }

}

// MARK: - String+Constants

private extension String {
    static let dotPath = "."
    static let empty = ""
    static let tildePath = "~"
    static let someFilePath = "/some/file/path"
}

// MARK: - URL+Constants

private extension URL {
    static let dotFile = URL(at: .dotPath)
    static let someFile = URL(at: .someFilePath)
    static let someURL = URL(string: "https://some.url.path")!
    static let tildeFile = URL(at: .tildePath)
}
