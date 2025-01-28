import Foundation
import Testing

@testable import ColibriLibrary

struct CreateFoldersTaskTests {
    
    // MARK: Properties
    
    private let spy = FileServiceSpy()
    
    // MARK: Functions tests

    @Test(arguments: [URL.someCurrentFolder, .someDotFolder, .someTildeFolder])
    func createFolders(with rootFolder: URL) async throws {
        // GIVEN
        let folders = Folder.allCases.map { rootFolder.appendingPath($0.path) }
        let actions = folders.map { FileServiceMock.Action.createFolder($0) }

        let createFolders = task(actions: actions)
        
        // WHEN
        try await createFolders(at: rootFolder)

        // THEN
        #expect(spy.actions.count == actions.count)

        for index in actions.indices {
            #expect(spy.actions[index] == .folderCreated(folders[index]))
        }
    }

}

// MARK: - Helpers

private extension CreateFoldersTaskTests {
    
    // MARK: Functions
    
    func task(actions: [FileServiceMock.Action]) -> CreateFoldersTask {
        .init(fileService: FileServiceMock(
            currentFolder: .someCurrentFolder,
            actions: actions,
            spy: spy
        ))
    }
    
}
