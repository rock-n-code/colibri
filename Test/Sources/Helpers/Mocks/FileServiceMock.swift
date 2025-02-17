import ColibriLibrary
import Foundation

final class FileServiceMock {
    
    // MARK: Properties
    
    private let folder: URL
    
    private var actions: [Action] = []
    
    private weak var spy: FileServiceSpy?
    
    // MARK: Initialisers
    
    init(
        currentFolder: URL,
        action: Action? = nil,
        spy: FileServiceSpy? = nil
    ) {
        self.actions = if let action {
            [action]
        } else {
            []
        }
        self.folder = currentFolder
        self.spy = spy
    }
    
    init(
        currentFolder: URL,
        actions: [Action],
        spy: FileServiceSpy? = nil
    ) {
        self.actions = actions
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
    
    func copyFile(from source: URL, to destination: URL) async throws (FileServiceError) {
        guard let nextAction else { return }
        
        switch nextAction {
        case .error(let error):
            throw error
        case let .copyFile(source, destination):
            try await spy?.copyFile(from: source, to: destination)
        default:
            break
        }
    }
    
    func createFile(at location: URL, with data: Data) async throws (FileServiceError) {
        guard let nextAction else { return }
        
        switch nextAction {
        case .error(let error):
            throw error
        case let .createFile(location, data):
            try await spy?.createFile(at: location, with: data)
        default:
            break
        }
    }
    
    func createFolder(at location: URL) async throws (FileServiceError) {
        guard let nextAction else { return }
        
        switch nextAction {
        case .error(let error):
            throw error
        case let .createFolder(location):
            try await spy?.createFolder(at: location)
        default:
            break
        }
    }
    
    func deleteItem(at location: URL) async throws (FileServiceError) {
        guard let nextAction else { return }
        
        switch nextAction {
        case .error(let error):
            throw error
        case let .deleteItem(location):
            try await spy?.deleteItem(at: location)
        default:
            break
        }
    }
    
    func isItemExists(at location: URL) async throws (FileServiceError) -> Bool {
        guard let nextAction else { return false }
        
        switch nextAction {
        case .error(let error):
            throw error
        case let .isItemExists(location, exists):
            try await spy?.isItemExists(at: location)
            return exists
        default:
            return false
        }
    }
    
}

// MARK: - Helpers

private extension FileServiceMock {
    
    // MARK: Computed
    
    var nextAction: Action? {
        guard !actions.isEmpty else {
            return nil
        }

        return actions.removeFirst()
    }
    
}

// MARK: - Actions

extension FileServiceMock {
    enum Action {
        case copyFile(URL, URL)
        case createFile(URL, Data)
        case createFolder(URL)
        case deleteItem(URL)
        case error(FileServiceError)
        case isItemExists(URL, Bool)
    }
}
