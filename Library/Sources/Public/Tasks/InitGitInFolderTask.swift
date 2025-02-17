import Foundation

public struct InitGitInFolderTask {
    
    // MARK: Properties
    
    private let terminalService: TerminalServicing

    // MARK: Initialisers
    
    public init(terminalService: TerminalServicing) {
        self.terminalService = terminalService
    }
    
    // MARK: Functions
    
    public func callAsFunction(at rootFolder: URL) async throws (TerminalServiceError) {
        let executableURL = URL(at: "/usr/bin/git")
        let pathFolder = rootFolder.pathString
        
        try await terminalService.run(executableURL, arguments: ["init", pathFolder])
        try await terminalService.run(executableURL, arguments: ["-C", pathFolder, "add", "."])
        try await terminalService.run(executableURL, arguments: ["-C", pathFolder, "commit", "-m", "Initial commit"])
    }
    
}
