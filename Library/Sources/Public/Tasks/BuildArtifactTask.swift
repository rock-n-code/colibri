import Foundation

public struct BuildArtifactTask {
    
    // MARK: Properties
    
    private let terminalService: TerminalServicing
    
    // MARK: Initialisers
    
    public init(terminalService: TerminalServicing) {
        self.terminalService = terminalService
    }
    
    // MARK: Functions
    
    public func callAsFunction(_ artifact: Artifact, at location: URL? = nil) async throws (TerminalServiceError) {
        let executableURL: URL = switch artifact {
        case .executable: .init(at: "/usr/bin/swift")
        case .image: .init(at: "/usr/local/bin/docker")
        }

        var arguments: [String] = switch artifact {
        case .executable: ["build"]
        case .image: ["compose", "build"]
        }

        if let location {
            if case .executable = artifact {
                arguments.append(contentsOf: ["--package-path", location.pathString])
            } else if case .image = artifact {
                arguments.insert(contentsOf: ["--project-directory", location.pathString], at: 1)
            }
        }
        
        try await terminalService.run(executableURL, arguments: arguments)
    }
    
}

