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
    
    public func copyFile(from source: URL, to destination: URL) async throws (FileServiceError) {
        guard try await !isItemExists(at: destination) else {
            throw FileServiceError.itemAlreadyExists
        }
        
        var itemData: Data?

        do {
            itemData = try Data(contentsOf: source)
        } catch {
            throw FileServiceError.itemEmptyData
        }
        
        do {
            try itemData?.write(to: destination, options: .atomic)
        } catch {
            throw FileServiceError.itemNotCopied
        }
    }

    public func createFolder(at location: URL) async throws (FileServiceError) {
        guard try await !isItemExists(at: location) else {
            throw FileServiceError.itemAlreadyExists
        }
        
        do {
            try fileManager.createDirectory(at: location, withIntermediateDirectories: true)
        } catch {
            throw FileServiceError.folderNotCreated
        }
    }
    
    public func deleteItem(at location: URL) async throws (FileServiceError) {
        guard try await isItemExists(at: location) else {
            throw FileServiceError.itemNotExists
        }
        
        do {
            try fileManager.removeItem(at: location)
        } catch {
            throw FileServiceError.itemNotDeleted
        }
    }
    
    public func isItemExists(at location: URL) async throws (FileServiceError) -> Bool {
        guard location.isFileURL else {
            throw FileServiceError.itemNotFileURL
        }
        
        let filePath = location.pathString
        
        return fileManager.fileExists(atPath: filePath)
    }
    
}
