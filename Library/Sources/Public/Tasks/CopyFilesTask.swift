import Foundation

public struct CopyFilesTask {

    // MARK: Properties
    
    private let bundle: Bundleable
    private let fileService: FileServicing
    
    // MARK: Initialisers
    
    public init(
        bundle: Bundleable? = nil,
        fileService: FileServicing
    ) {
        self.bundle = bundle ?? Bundle.module
        self.fileService = fileService
    }

    // MARK: Functions
    
    public func callAsFunction(to rootFolder: URL) async throws (FileServiceError) {
        for file in File.allCases {
            guard let source = bundle.url(
                forResource: file.rawValue,
                withExtension: nil,
                subdirectory: file.resourcePath
            ) else {
                assertionFailure("URL should have been initialized.")
                return
            }
            
            let destination = rootFolder.appendingPath(file.filePath)

            try await fileService.copyFile(from: source, to: destination)
        }
    }
    
}
