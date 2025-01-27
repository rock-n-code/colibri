import Foundation

public protocol FileServicing {
    
    // MARK: Computed
    
    var currentFolder: URL { get async }
    
    // MARK: Functions
    
    func createFolder(at url: URL) async throws (FileServiceError)
    func delete(at url: URL) async throws (FileServiceError)
    func exists(at url: URL) async throws (FileServiceError) -> Bool
    
}

// MARK: - Errors

public enum FileServiceError: Error, Equatable {
    case folderNotCreated
    case urlAlreadyExists
    case urlNotDeleted
    case urlNotExists
    case urlNotFileURL
}
