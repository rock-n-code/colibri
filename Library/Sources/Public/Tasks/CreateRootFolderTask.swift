import Foundation

public struct CreateRootFolderTask {
    
    // MARK: Properties
    
    private let fileService: FileServicing
    
    // MARK: Initialisers
    
    public init(fileService: FileServicing) {
        self.fileService = fileService
    }
    
    // MARK: Functions
    
    public func callAsFunction(name: String, at location: URL? = nil) async throws -> URL {
        guard !name.isEmpty else {
            throw CreateRootFolderError.nameIsEmpty
        }

        let rootFolder = if let location {
            location
        } else {
            await fileService.currentFolder
        }

        let newFolder = rootFolder.appendingPath(name)

        try await fileService.createFolder(at: newFolder)
        
        return newFolder
    }
    
}

// MARK: - Errors

public enum CreateRootFolderError: Error {
    case nameIsEmpty
}
