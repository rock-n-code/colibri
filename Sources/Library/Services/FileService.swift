import Foundation

public struct FileService: FileServicing {

    // MARK: Properties
    
    private let fileManager: FileManager
    
    // MARK: Initialisers
    
    public init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
    // MARK: Computed
    
    public var currentFolder: URL {
        get async {
            .init(at: fileManager.currentDirectoryPath)
        }
    }
    
    // MARK: Functions

    public func createFolder(at url: URL) async throws (FileServiceError) {
        guard try await !exists(at: url) else {
            throw FileServiceError.urlAlreadyExists
        }
        
        do {
            try fileManager.createDirectory(
                at: url,
                withIntermediateDirectories: true
            )
        } catch {
            throw FileServiceError.folderNotCreated
        }
    }
    
    public func delete(at url: URL) async throws (FileServiceError) {
        guard try await exists(at: url) else {
            throw FileServiceError.urlNotExists
        }
        
        do {
            try fileManager.removeItem(at: url)
        } catch {
            throw FileServiceError.urlNotDeleted
        }
    }
    
    public func exists(at url: URL) async throws (FileServiceError) -> Bool {
        guard url.isFileURL else {
            throw FileServiceError.urlNotFileURL
        }
        
        let filePath = getPath(for: url)
        
        return fileManager.fileExists(atPath: filePath)
    }
    
}

// MARK: - Helpers

private extension FileService {
    
    // MARK: Functions
    
    func getPath(for url: URL) -> String {
        if #available(macOS 13.0, *) {
            return url.path()
        } else {
            return url.path
        }
    }
    
}
