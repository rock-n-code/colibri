import ArgumentParser
import Foundation

extension Colibri.Create {
    struct Options: ParsableArguments {
        
        // MARK: Properties
        
        @Option(name: .shortAndLong)
        var name: String
        
        @Option(name: .shortAndLong)
        var location: String?
        
        // MARK: Computed
        
        var locationURL: URL? {
            location.flatMap { URL(fileURLWithPath: $0) }
        }
        
    }
}
