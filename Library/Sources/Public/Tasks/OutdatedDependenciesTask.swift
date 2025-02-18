import Foundation

public struct OutdatedDependenciesTask {

    // MARK: Properties
    
    private let terminalService: TerminalServicing
    
    // MARK: Initialisers
    
    public init(terminalService: TerminalServicing) {
        self.terminalService = terminalService
    }
    
    // MARK: Functions
    
    public func callAsFunction(at location: URL? = nil) async throws (TerminalServiceError) {
        let executableURL = URL(at: "/usr/bin/swift")
        
        var arguments: [String] = ["package", "update"]
        
        if let location {
            arguments.append(contentsOf: ["--package-path", location.pathString])
        }
        
        arguments.append("--dry-run")
        
        try await terminalService.run(executableURL, arguments: arguments)
    }
    
}
