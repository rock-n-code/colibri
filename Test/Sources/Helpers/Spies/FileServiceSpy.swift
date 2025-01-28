import Foundation

@testable import ColibriLibrary

final class FileServiceSpy {
    
    // MARK: Properties
    
    private(set) var actions: [Action] = []
    
}

// MARK: - FileServicing

extension FileServiceSpy: FileServicing {

    var currentFolder: URL {
        get async { .someCurrentFolder }
    }
    
    func copyFile(from source: URL, to destination: URL) async throws (FileServiceError) {
        actions.append(.fileCopied(source, destination))
    }
    
    func createFolder(at location: URL) async throws (FileServiceError) {
        actions.append(.folderCreated(location))
    }
    
    func deleteItem(at location: URL) async throws (FileServiceError) {
        actions.append(.itemDeleted(location))
    }
    
    @discardableResult
    func isItemExists(at location: URL) async throws (FileServiceError) -> Bool {
        actions.append(.itemExists(location))

        return .random()
    }
    
}

// MARK: - Action

extension FileServiceSpy {
    enum Action: Equatable {
        case fileCopied(_ source: URL, _ destination: URL)
        case folderCreated(_ location: URL)
        case itemDeleted(_ location: URL)
        case itemExists(_ location: URL)
    }
}
