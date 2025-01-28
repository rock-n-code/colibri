import Foundation

extension Pipe {
    
    // MARK: Computed
    
    var availableData: AsyncAvailableData { .init(self) }
    
}

// MARK: - AsyncAvailableData

extension Pipe {
    struct AsyncAvailableData {
        
        // MARK: Properties
        
        private let pipe: Pipe
        
        // MARK: Initialisers
        
        init(_ pipe: Pipe) {
            self.pipe = pipe
        }
        
        // MARK: Functions
        
        func append() async -> Data {
            var data = Data()
            
            for await availableData in self {
                data.append(availableData)
            }
            
            return data
        }
        
    }
}

// MARK: - AsyncSequence

extension Pipe.AsyncAvailableData: AsyncSequence {
    
    // MARK: Type aliases
    
    typealias AsyncIterator = AsyncStream<Data>.Iterator
    typealias Element = Data
    
    // MARK: Functions
    
    func makeAsyncIterator() -> AsyncIterator {
        AsyncStream { continuation in
            pipe.fileHandleForReading.readabilityHandler = { @Sendable handler in
                let data = handler.availableData
                
                guard !data.isEmpty else {
                    continuation.finish()
                    return
                }
                
                continuation.yield(data)
            }
            
            continuation.onTermination = { _ in
                pipe.fileHandleForReading.readabilityHandler = nil
            }
        }
        .makeAsyncIterator()
    }
    
}
