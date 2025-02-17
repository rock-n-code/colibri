import Foundation

public struct FileService {
    
    // MARK: Properties
    
    private let fileManager: FileManager
    
    // MARK: Initialisers
    
    public init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
}

// MARK: - FileServicing

extension FileService: FileServicing {

    // MARK: Computed
    
    public var currentFolder: URL {
        get async {
            .init(at: fileManager.currentDirectoryPath)
        }
    }
    
    // MARK: Functions
    
    public func copyFile(from source: URL, to destination: URL) async throws (FileServiceError) {
        guard try await !isItemExists(at: destination) else {
            throw .itemAlreadyExists
        }
        
        var itemData: Data?

        do {
            itemData = try Data(contentsOf: source)
        } catch {
            throw .itemEmptyData
        }
        
        do {
            try itemData?.write(to: destination, options: .atomic)
        } catch {
            throw .itemNotCopied
        }
    }
    
    public func createFile(at location: URL, with data: Data) async throws (FileServiceError) {
        guard try await !isItemExists(at: location) else {
            throw .itemAlreadyExists
        }
        
        guard !data.isEmpty else {
            throw .fileDataIsEmpty
        }
        
        do {
            try data.write(to: location, options: .atomic)
        } catch {
            throw .fileNotCreated
        }
    }

    public func createFolder(at location: URL) async throws (FileServiceError) {
        guard try await !isItemExists(at: location) else {
            throw .itemAlreadyExists
        }
        
        do {
            try fileManager.createDirectory(at: location, withIntermediateDirectories: true)
        } catch {
            throw .folderNotCreated
        }
    }
    
    public func deleteItem(at location: URL) async throws (FileServiceError) {
        guard try await isItemExists(at: location) else {
            throw .itemNotExists
        }
        
        do {
            try fileManager.removeItem(at: location)
        } catch {
            throw .itemNotDeleted
        }
    }
    
    public func isItemExists(at location: URL) async throws (FileServiceError) -> Bool {
        guard location.isFileURL else {
            throw .itemNotFileURL
        }
        
        let filePath = location.pathString
        
        return fileManager.fileExists(atPath: filePath)
    }
    
}
