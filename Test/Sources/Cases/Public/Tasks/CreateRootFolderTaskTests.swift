import Foundation
import Testing

@testable import ColibriLibrary

struct CreateRootFolderTaskTests {

    // MARK: Functions tests
    
    @Test(arguments: [String.someProjectName], [URL.someCurrentProjectFolder, .someNewProjectFolder, .someDotProjectFolder, .someTildeProjectFolder])
    func task(
        name: String,
        expects folder: URL
    ) async throws {
        // GIVEN
        let location: URL? = switch folder {
            case .someNewProjectFolder: .someNewFolder
            case .someDotProjectFolder: .someDotFolder
            case .someTildeProjectFolder: .someTildeFolder
            default: nil
        }
        
        let task = CreateRootFolderTask(fileService: FileServiceMock(
            currentFolder: .someCurrentFolder,
            action: .createFolder(folder)
        ))

        // WHEN
        let result = try await task(name: name,
                                    at: location)
        
        // THEN
        #expect(result == folder)
        #expect(result.isFileURL == true)
    }
    
    @Test(arguments: [String.someProjectName], [FileServiceError.itemAlreadyExists])
    func task(
        name: String,
        throws error: FileServiceError
    ) async throws {
        // GIVEN
        let task = CreateRootFolderTask(fileService: FileServiceMock(
            currentFolder: .someCurrentFolder,
            action: .error(error)
        ))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await task(name: name)
        }
    }
    
    @Test(arguments: [String.someEmptyName], [CreateRootFolderError.nameIsEmpty])
    func task(
        name: String,
        throws error: CreateRootFolderError
    ) async throws {
        // GIVEN
        let task = CreateRootFolderTask(fileService: FileServiceMock(
            currentFolder: .someCurrentFolder
        ))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await task(name: name)
        }
    }

}

// MARK: - String+Constants

private extension String {
    static let someEmptyName = ""
    static let someProjectName = "SomeProjectName"
}

// MARK: - URL+Constants

private extension URL {
    static let someCurrentProjectFolder = URL.someCurrentFolder.appendingPath(.someProjectName)
    static let someDotProjectFolder = URL.someDotFolder.appendingPath(.someProjectName)
    static let someNewProjectFolder = URL.someNewFolder.appendingPath(.someProjectName)
    static let someTildeProjectFolder = URL.someTildeFolder.appendingPath(.someProjectName)
}
