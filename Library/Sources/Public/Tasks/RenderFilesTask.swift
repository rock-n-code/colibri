import Foundation

public struct RenderFilesTask {
    
    // MARK: Computed
    
    private let fileService: FileServicing
    private let templateService: TemplateServicing

    // MARK: Initialisers

    public init(
        fileService: FileServicing,
        templateService: TemplateServicing
    ) {
        self.fileService = fileService
        self.templateService = templateService
    }
    
    // MARK: Functions
    
    public func callAsFunction(
        at rootFolder: URL,
        with model: Project
    ) async throws {
        for template in Template.allCases {
            let content = try await templateService.render(model, on: template.rawValue)
            let fileURL = rootFolder.appendingPath(template.filePath)

            try await fileService.createFile(at: fileURL, with: Data(content.utf8))
        }
    }
    
}
