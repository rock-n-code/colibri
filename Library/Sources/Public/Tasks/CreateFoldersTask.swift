import Foundation

public struct CreateFoldersTask {

    // MARK: Properties

    private let fileService: FileServicing

    // MARK: Initialisers
    
    public init(fileService: FileServicing) {
        self.fileService = fileService
    }
    
    // MARK: Functions
    
    public func callAsFunction(at rootFolder: URL) async throws {
        let folders = Folder.allCases.map { rootFolder.appendingPath($0.path) }
        
        for folder in folders {
            try await fileService.createFolder(at: folder)
        }
    }
    
}
