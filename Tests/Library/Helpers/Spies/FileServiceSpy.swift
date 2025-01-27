import Foundation

@testable import ColibriLibrary

final class FileServiceSpy {
    
    // MARK: Properties
    
    private(set) var isCreateFolderCalled: Bool = false
    private(set) var isDeleteCalled: Bool = false
    private(set) var isExistsAtCalled: Bool = false
    private(set) var urlCalled: URL?
    
}

// MARK: - FileServicing

extension FileServiceSpy: FileServicing {
    var currentFolder: URL {
        get async { .someCurrentFolder }
    }
    
    func createFolder(at url: URL) async throws(FileServiceError) {
        isCreateFolderCalled = true
        urlCalled = url
    }
    
    func delete(at url: URL) async throws(FileServiceError) {
        isDeleteCalled = true
        urlCalled = url
    }
    
    @discardableResult
    func exists(at url: URL) async throws(FileServiceError) -> Bool {
        isExistsAtCalled = true
        urlCalled = url
        
        return .random()
    }
    
}
