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
    
    // MARK: Functions
    
    @Test(arguments: [URL.someNewFolder, .someNewFile])
    func createFolder(with url: URL) async throws {
        // GIVEN
        let service = FileServiceMock(
            currentFolder: .someCurrentFolder,
            action: .createFolder(url),
            spy: spy
        )

        // WHEN
        try await service.createFolder(at: url)
        
        // THEN
        #expect(spy.isCreateFolderCalled == true)
        #expect(spy.urlCalled == url)
    }
    
    @Test(arguments: zip([URL.someExistingFolder, .someExistingFile, .someRandomURL],
                         [FileServiceError.urlAlreadyExists, .urlAlreadyExists, .urlNotFileURL]))
    func createFolder(
        with url: URL,
        throws error: FileServiceError
    ) async throws {
        // GIVEN
        let service = FileServiceMock(
            currentFolder: .someCurrentFolder,
            action: .error(error),
            spy: spy
        )

        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.createFolder(at: url)
        }

        #expect(spy.isCreateFolderCalled == false)
        #expect(spy.urlCalled == nil)
    }
    
    @Test(arguments: [URL.someNewFolder, .someNewFile])
    func delete(with url: URL) async throws {
        // GIVEN
        let service = FileServiceMock(
            currentFolder: .someCurrentFolder,
            action: .delete(url),
            spy: spy
        )

        // WHEN
        try await service.delete(at: url)

        // THEN
        #expect(spy.isDeleteCalled == true)
        #expect(spy.urlCalled == url)
    }
    
    @Test(arguments: zip([URL.someNewFolder, .someNewFile, .someRandomURL],
                         [FileServiceError.urlNotExists, .urlNotExists, .urlNotFileURL]))
    func delete(
        with url: URL,
        throws error: FileServiceError
    ) async throws {
        // GIVEN
        let service = FileServiceMock(
            currentFolder: .someCurrentFolder,
            action: .error(error),
            spy: spy
        )
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.delete(at: url)
        }

        #expect(spy.isDeleteCalled == false)
        #expect(spy.urlCalled == nil)
    }
    
    @Test(arguments: zip([URL.someExistingFolder, .someExistingFile, .someNewFolder, .someNewFile],
                         [true, true, false, false]))
    func exists(
        with url: URL,
        expects outcome: Bool
    ) async throws {
        // GIVEN
        let service = FileServiceMock(
            currentFolder: .someCurrentFolder,
            action: .exists(url, outcome),
            spy: spy
        )

        // WHEN
        let result = try await service.exists(at: url)
        
        // THEN
        #expect(result == outcome)

        #expect(spy.isExistsAtCalled == true)
        #expect(spy.urlCalled == url)
    }
    
    @Test(arguments: zip([URL.someRandomURL], [FileServiceError.urlNotFileURL]))
    func exists(
        with url: URL,
        throws error: FileServiceError
    ) async throws {
        // GIVEN
        let service = FileServiceMock(
            currentFolder: .someCurrentFolder,
            action: .error(error),
            spy: spy
        )

        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.exists(at: url)
        }
        
        #expect(spy.isExistsAtCalled == false)
        #expect(spy.urlCalled == nil)
    }

}
