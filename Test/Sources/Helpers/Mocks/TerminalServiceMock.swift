import ColibriLibrary
import Foundation

final class TerminalServiceMock {
    
    // MARK: Properties
    
    private var actions: [Action] = []
    
    private weak var spy: TerminalServiceSpy?
    
    // MARK: Initialisers
    
    init(
        action: Action,
        spy: TerminalServiceSpy? = nil
    ) {
        self.actions.append(action)
        self.spy = spy
    }
    
    init(
        actions: [Action],
        spy: TerminalServiceSpy? = nil
    ) {
        self.actions = actions
        self.spy = spy
    }
    
}

// MARK: - TerminalServicing

extension TerminalServiceMock: TerminalServicing {
    
    // MARK: Functions
    
    func run(_ executableURL: URL, arguments: [String]) async throws (TerminalServiceError) -> String {
        guard let nextAction else { return .empty }
        
        switch nextAction {
        case .error(let error):
            throw error
        case let .run(executableURL, arguments):
            try await spy?.run(executableURL, arguments: arguments)
            return .empty
        }
    }
    
}

// MARK: - Helpers

private extension TerminalServiceMock {
    
    // MARK: Computed
    
    var nextAction: Action? {
        guard !actions.isEmpty else {
            return nil
        }
        
        return actions.removeFirst()
    }
    
}

// MARK: - Actions

extension TerminalServiceMock {
    enum Action {
        case error(TerminalServiceError)
        case run(URL, [String])
    }
}

// MARK: - String+Constants

private extension String {
    static let empty = ""
}
