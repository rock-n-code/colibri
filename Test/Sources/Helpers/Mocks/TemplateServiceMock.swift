import ColibriLibrary
import Foundation

final class TemplateServiceMock {
    
    // MARK: Properties
    
    private var actions: [Action] = []
    
    private weak var spy: TemplateServiceSpy?
    
    // MARK: Initialisers
    
    init(
        action: Action,
        spy: TemplateServiceSpy? = nil
    ) {
        self.actions.append(action)
        self.spy = spy
    }
    
}

// MARK: - TemplateServicing

extension TemplateServiceMock: TemplateServicing {
    
    // MARK: Functions
    
    @discardableResult
    func render(_ object: Any, on template: String) async throws(TemplateServiceError) -> String {
        guard let nextAction else { return .empty }
        
        switch nextAction {
        case .error(let error):
            throw error
        case .render(let content):
            try await spy?.render(object, on: template)
            return content
        }
    }
    
}

// MARK: - Helpers

private extension TemplateServiceMock {
    
    // MARK: Computed
    
    var nextAction: Action? {
        guard !actions.isEmpty else {
            return nil
        }
        
        return actions.removeFirst()
    }
    
}


// MARK: - Actions

extension TemplateServiceMock {
    enum Action {
        case error(TemplateServiceError)
        case render(String)
    }
}

// MARK: - String+Constants

private extension String {
    static let empty = ""
}
