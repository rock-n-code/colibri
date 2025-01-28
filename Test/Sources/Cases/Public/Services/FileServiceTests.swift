import ColibriLibrary
import Foundation
import Testing

struct FileServiceTests {
    
    // MARK: Properties
    
    private let spy = FileServiceSpy()

    // MARK: Properties tests

    @Test func currentFolder() async {
        // GIVEN
        let url: URL = .someCurrentFolder
        
        let service = FileServiceMock(currentFolder: url)

        // WHEN
        let folder = await service.currentFolder

        // THEN
        #expect(folder == url)
        #expect(folder.isFileURL == true)
    }
    
    // MARK: Functions tests
    
    @Test(arguments: zip([URL.someExistingFile, .someExistingFolder],
                         [URL.someNewFile, .someNewFolder]))
    func copyFile(from source: URL, to destination: URL) async throws {
        // GIVEN
        let service = service(action: .copyFile(source, destination))

        // WHEN
        try await service.copyFile(from: source, to: destination)

        // THENn
        #expect(spy.actions.count == 1)
        
        let action = try #require(spy.actions.last)

        #expect(action == .fileCopied(source, destination))
    }
    
    @Test(arguments: [FileServiceError.itemAlreadyExists, .itemEmptyData, .itemNotCopied])
    func copyItem(throws error: FileServiceError) async throws {
        // GIVEN
        let service = service(action: .error(error))

        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.copyFile(from: .someExistingFile, to: .someNewFile)
        }
        
        #expect(spy.actions.isEmpty == true)
    }
    
    @Test(arguments: [URL.someNewFolder, .someNewFile])
    func createFolder(with location: URL) async throws {
        // GIVEN
        let service = service(action: .createFolder(location))

        // WHEN
        try await service.createFolder(at: location)
        
        // THEN
        #expect(spy.actions.count == 1)
        
        let action = try #require(spy.actions.last)
        
        #expect(action == .folderCreated(location))
    }
    
    @Test(arguments: zip([URL.someExistingFolder, .someExistingFile, .someRandomURL],
                         [FileServiceError.itemAlreadyExists, .itemAlreadyExists, .itemNotFileURL]))
    func createFolder(
        with location: URL,
        throws error: FileServiceError
    ) async throws {
        // GIVEN
        let service = service(action: .error(error))

        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.createFolder(at: location)
        }
        
        #expect(spy.actions.isEmpty == true)
    }
    
    @Test(arguments: [URL.someNewFolder, .someNewFile])
    func deleteItem(with location: URL) async throws {
        // GIVEN
        let service = service(action: .deleteItem(location))

        // WHEN
        try await service.deleteItem(at: location)

        // THEN
        #expect(spy.actions.count == 1)
        
        let action = try #require(spy.actions.last)
        
        #expect(action == .itemDeleted(location))
    }
    
    @Test(arguments: zip([URL.someNewFolder, .someNewFile, .someRandomURL],
                         [FileServiceError.itemNotExists, .itemNotExists, .itemNotFileURL]))
    func deleteItem(
        with location: URL,
        throws error: FileServiceError
    ) async throws {
        // GIVEN
        let service = service(action: .error(error))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.deleteItem(at: location)
        }

        #expect(spy.actions.isEmpty == true)
    }
    
    @Test(arguments: zip([URL.someExistingFolder, .someExistingFile, .someNewFolder, .someNewFile],
                         [true, true, false, false]))
    func isItemExists(
        with location: URL,
        expects outcome: Bool
    ) async throws {
        // GIVEN
        let service = service(action: .isItemExists(location, outcome))

        // WHEN
        let result = try await service.isItemExists(at: location)
        
        // THEN
        #expect(result == outcome)

        let action = try #require(spy.actions.last)
        
        #expect(action == .itemExists(location))
    }
    
    @Test(arguments: zip([URL.someRandomURL], [FileServiceError.itemNotFileURL]))
    func isItemExists(
        with location: URL,
        throws error: FileServiceError
    ) async throws {
        // GIVEN
        let service = service(action: .error(error))

        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.isItemExists(at: location)
        }
        
        #expect(spy.actions.isEmpty == true)
    }

}

// MARK: - Helpers

private extension FileServiceTests {
    
    // MARK: Functions
    
    func service(action: FileServiceMock.Action) -> FileServiceMock {
        .init(
            currentFolder: .someCurrentFolder,
            action: action,
            spy: spy
        )
    }
    
}
