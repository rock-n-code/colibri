import Foundation
import Mustache

public struct TemplateService {
    
    // MARK: Properties
    
    private let mustacheRenderer: MustacheLibrary
    
    // MARK: Initialisers
    
    public init(
        bundle: Bundleable? = nil,
        templateFolder: String
    ) async throws (TemplateServiceError) {
        guard let pathResources = (bundle ?? Bundle.module).resourcePath else {
            throw .resourcePathNotFound
        }
        
        let pathTemplates = pathResources + "/" + templateFolder
        
        do {
            self.mustacheRenderer = try await MustacheLibrary(directory: pathTemplates)
        } catch {
            throw .serviceNotInitialized
        }
    }
    
}

// MARK: - TemplateServicing

extension TemplateService: TemplateServicing {

    // MARK: Functions
    
    public func render(_ object: Any, on template: String) async throws (TemplateServiceError) -> String {
        guard mustacheRenderer.getTemplate(named: template) != nil else {
            throw .templateNotFound
        }
        
        guard let content = mustacheRenderer.render(object, withTemplate: template) else {
            throw .contentNotRendered
        }
        
        return content
    }
    
}

