import ColibriLibrary

final class TemplateServiceSpy {
    
    // MARK: Properties
    
    private(set) var actions: [Action] = []
    
}

// MARK: - TemplateServicing

extension TemplateServiceSpy: TemplateServicing {
    
    // MARK: Functions
    
    @discardableResult
    func render(_ object: Any, on template: String) async throws (TemplateServiceError) -> String {
        actions.append(.rendered(object, template))
        
        return .content
    }
    
}

// MARK: - Actions

extension TemplateServiceSpy {
    enum Action {
        case rendered(_ object: Any, _ template: String)
    }
}

// MARK: - String+Constants

private extension String {
    static let content = ""
}
