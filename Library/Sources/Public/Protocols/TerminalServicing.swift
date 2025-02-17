import Foundation

public protocol TerminalServicing {
    
    // MARK: Functions
    
    @discardableResult
    func run(_ executableURL: URL, arguments: [String]) async throws (TerminalServiceError) -> String
    
}

// MARK: - Errors

public enum TerminalServiceError: Error, Equatable {
    case captured(_ output: String)
    case output(_ output: String)
    case unexpected
}

