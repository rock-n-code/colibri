import Foundation

struct RunProcessTask {
    
    // MARK: Type aliases
    
    typealias Output = String
    
    // MARK: Properties
    
    private var process: Processable
    
    // MARK: Initialisers
    
    init(process: Processable) {
        self.process = process
    }
    
    // MARK: Functions
    
    @discardableResult
    mutating func callAsFunction(
        path: String, arguments: [String] = []
    ) async throws (RunProcessError) -> Output {
        process.executableURL = URL(at: path)
        process.arguments = arguments
        
        let pipeError = Pipe()
        let pipeOutput = Pipe()
        
        process.standardError = pipeError
        process.standardOutput = pipeOutput
        
        async let streamOutput = pipeOutput.availableData.append()
        async let streamError = pipeError.availableData.append()
        
        do {
            try process.run()
            
            let dataOutput = await streamOutput
            let dataError = await streamError
            
            guard dataError.isEmpty else {
                guard let errorOutput = String(data: dataError, encoding: .utf8) else {
                    throw RunProcessError.unexpected
                }
                
                throw RunProcessError.output(errorOutput)
            }
            
            guard let output = String(data: dataOutput, encoding: .utf8) else {
                throw RunProcessError.unexpected
            }
            
            return await withCheckedContinuation { continuation in
                process.terminationHandler = { _ in
                    continuation.resume(returning: output)
                }
            }
        } catch let error as RunProcessError {
            throw error
        } catch {
            throw RunProcessError.captured(error.localizedDescription)
        }
    }
    
}

// MARK: - Errors

public enum RunProcessError: Error, Equatable {
    case captured(_ output: String)
    case output(_ output: String)
    case unexpected
}
