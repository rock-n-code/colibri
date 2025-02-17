public protocol TemplateServicing {
    
    // MARK: Functions
    
    func render(_ object: Any, on template: String) async throws (TemplateServiceError) -> String
    
}

// MARK: - Errors

public enum TemplateServiceError: Error {
    case contentNotRendered
    case resourcePathNotFound
    case serviceNotInitialized
    case templateNotFound
}
