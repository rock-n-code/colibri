import Foundation

public struct CleanProjectTask {
    
    // MARK: Properties
    
    private let terminalService: TerminalServicing
    
    // MARK: Initialisers
    
    public init(terminalService: TerminalServicing) {
        self.terminalService = terminalService
    }
    
    // MARK: Functions
    
    public func callAsFunction(
        at location: URL? = nil,
        shouldReset: Bool = false,
        purgeCache: Bool = false
    ) async throws (TerminalServiceError) {
        let executableURL = URL(at: "/usr/bin/swift")
        
        var arguments: [String] = ["package"]
        
        if let location {
            arguments.append(contentsOf: ["--package-path", location.pathString])
        }
        
        arguments.insert("clean", at: 1)
        
        try await terminalService.run(executableURL, arguments: arguments)
        
        if shouldReset {
            arguments.remove(at: 1)
            arguments.insert("reset", at: 1)

            try await terminalService.run(executableURL, arguments: arguments)
        }
        
        if purgeCache {
            arguments.remove(at: 1)
            arguments.insert("purge-cache", at: 1)
            
            try await terminalService.run(executableURL, arguments: arguments)
        }
    }
    
}
