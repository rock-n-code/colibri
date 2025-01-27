import ColibriLibrary
import Foundation

struct FileServiceMock {
    
    // MARK: Properties
    
    private let action: Action?
    private let folder: URL
    
    private weak var spy: FileServiceSpy?
    
    // MARK: Initialisers
    
    init(
        currentFolder: URL,
        action: Action? = nil,
        spy: FileServiceSpy? = nil
    ) {
        self.action = action
        self.folder = currentFolder
        self.spy = spy
    }
    
}

// MARK: - FileServicing

extension FileServiceMock: FileServicing {
    
    // MARK: Computed
    
    var currentFolder: URL {
        get async { folder }
    }
    
    // MARK: Functions
    
    func createFolder(at url: URL) async throws(FileServiceError) {
        switch action {
        case .error(let error):
            throw error
        case let .createFolder(url):
            try await spy?.createFolder(at: url)
        default:
            break
        }
    }
    
    func delete(at url: URL) async throws(FileServiceError) {
        switch action {
        case .error(let error):
            throw error
        case let .delete(url):
            try await spy?.delete(at: url)
        default:
            break
        }
    }
    
    func exists(at url: URL) async throws(FileServiceError) -> Bool {
        switch action {
        case .error(let error):
            throw error
        case let .exists(url, exists):
            try await spy?.exists(at: url)
            return exists
        default:
            return false
        }
    }
    
}

// MARK: - Enumerations

extension FileServiceMock {
    enum Action {
        case createFolder(URL)
        case delete(URL)
        case error(FileServiceError)
        case exists(URL, Bool)
    }
}
