import Foundation

public struct TerminalService {
    
    // MARK: Initialisers
    
    public init() {}
    
}

// MARK: - TerminalServicing

extension TerminalService: TerminalServicing {
    
    // MARK: Functions
    
    public func run(_ executableURL: URL, arguments: [String]) async throws (TerminalServiceError) -> String {
        let process = Process()
        let standardError = Pipe()
        let standardOutput = Pipe()

        process.executableURL = executableURL
        process.arguments = arguments
        process.standardError = standardError
        process.standardOutput = standardOutput
        
        async let streamOutput = standardOutput.availableData.append()
        async let streamError = standardError.availableData.append()
        
        do {
            try process.run()
            
            let dataOutput = await streamOutput
            let dataError = await streamError
            
            guard dataError.isEmpty else {
                guard let errorOutput = String(data: dataError, encoding: .utf8) else {
                    throw TerminalServiceError.unexpected
                }
                
                throw TerminalServiceError.output(errorOutput)
            }
            
            guard let output = String(data: dataOutput, encoding: .utf8) else {
                throw TerminalServiceError.unexpected
            }
            
            return await withCheckedContinuation { continuation in
                process.terminationHandler = { _ in
                    continuation.resume(returning: output)
                }
            }
        } catch let error as TerminalServiceError {
            throw error
        } catch {
            throw .captured(error.localizedDescription)
        }
    }
    
}
