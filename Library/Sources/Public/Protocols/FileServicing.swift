import Foundation

public protocol FileServicing {
    
    // MARK: Computed
    
    var currentFolder: URL { get async }
    
    // MARK: Functions
    
    func copyFile(from source: URL, to destination: URL) async throws (FileServiceError)
    func createFolder(at location: URL) async throws (FileServiceError)
    func deleteItem(at location: URL) async throws (FileServiceError)
    func isItemExists(at location: URL) async throws (FileServiceError) -> Bool
    
}

// MARK: - Errors

public enum FileServiceError: Error, Equatable {
    case folderNotCreated
    case itemAlreadyExists
    case itemEmptyData
    case itemNotCopied
    case itemNotDeleted
    case itemNotExists
    case itemNotFileURL
}
