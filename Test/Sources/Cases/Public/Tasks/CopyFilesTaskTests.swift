import Foundation
import Testing

@testable import ColibriLibrary

struct CopyFilesTaskTests {

    // MARK: Properties
    
    private let resourceFolder = URL.someExistingFolder
    private let rootFolder = URL.someNewFolder
    
    private let spy = FileServiceSpy()
    
    // MARK: Functions tests

    @Test func copyFiles() async throws {
        // GIVEN
        let files = files(of: File.allCases)
        let actions = files.map { FileServiceMock.Action.copyFile($0.source, $0.destination) }

        let copyFiles = task(actions: actions)

        // WHEN
        try await copyFiles(to: rootFolder)

        // THEN
        #expect(spy.actions.count == actions.count)
        
        files.enumerated().forEach { index, file in
            #expect(spy.actions[index] == .fileCopied(file.source, file.destination))
        }
    }
    
    @Test(arguments: [FileServiceError.itemAlreadyExists, .itemEmptyData, .itemNotCopied])
    func copyFiles(throws error: FileServiceError) async throws {
        // GIVEN
        let files = files(of: Array(File.allCases[0...2]))
        let actions = files.map { FileServiceMock.Action.copyFile($0.source, $0.destination) }

        let copyFiles = task(actions: actions + [.error(error)])
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await copyFiles(to: rootFolder)
        }
        
        #expect(spy.actions.count == actions.count)
        
        files.enumerated().forEach { index, file in
            #expect(spy.actions[index] == .fileCopied(file.source, file.destination))
        }
    }

}

// MARK: - Helpers

private extension CopyFilesTaskTests {
    
    // MARK: Type aliases
    
    typealias FileURL = (source: URL, destination: URL)

    // MARK: Functions
    
    func files(of resourceFiles: [File]) -> [FileURL] {
        resourceFiles.map { (resourceFolder.appendingPath($0.rawValue), rootFolder.appendingPath($0.fileName)) }
    }
    
    func task(actions: [FileServiceMock.Action]) -> CopyFilesTask {
        .init(fileService: FileServiceMock(
            currentFolder: .someCurrentFolder,
            actions: actions,
            spy: spy
        ))
    }
        
}
