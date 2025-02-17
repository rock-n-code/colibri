import ColibriLibrary
import Foundation

final class TerminalServiceSpy {
    
    // MARK: Properties
    
    private(set) var actions: [Action] = []
    
}

// MARK: - TerminalServicing

extension TerminalServiceSpy: TerminalServicing {
    
    // MARK: Functions
    
    @discardableResult
    func run(_ executableURL: URL, arguments: [String]) async throws(TerminalServiceError) -> String {
        actions.append(.ran(executableURL, arguments))
        
        return .content
    }
    
}

// MARK: - Actions

extension TerminalServiceSpy {
    enum Action: Equatable {
        case ran(_ executableURL: URL, _ arguments: [String])
    }
}

// MARK: - String+Constants

private extension String {
    static let content = ""
}
