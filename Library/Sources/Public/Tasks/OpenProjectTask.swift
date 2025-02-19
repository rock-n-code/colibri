import Foundation

public struct OpenProjectTask {
    
    // MARK: Properties
    
    private let terminalService: TerminalServicing
    
    // MARK: Initialisers
    
    public init(terminalService: TerminalServicing) {
        self.terminalService = terminalService
    }
    
    // MARK: Functions
    
    public func callAsFunction(with ide: IDE, at location: URL? = nil) async throws (TerminalServiceError) {
        let executableURL: URL = switch ide {
        case .vscode: .init(at: "/usr/local/bin/code")
        case .xcode: .init(at: "/usr/bin/open")
        }
        
        let locationPath = switch ide {
        case .vscode: location?.pathString ?? "."
        case .xcode: location?.appendingPath(.Path.package).pathString ?? .Path.package
        }
        
        let arguments: [String] = switch ide {
        case .vscode: [locationPath]
        case .xcode: ["-a", "Xcode", locationPath]
        }

        try await terminalService.run(executableURL, arguments: arguments)
    }
    
}

// MARK: - String+Constants

private extension String {
    enum Path {
        static let package = "Package.swift"
    }
}
