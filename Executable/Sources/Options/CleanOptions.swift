import ArgumentParser
import ColibriLibrary

extension Colibri.Clean {
    struct Options: ParsableArguments, Locationable {
        
        // MARK: Properties
        
        @Flag(name: .shortAndLong)
        var reset: Bool = false
        
        @Flag(name: .shortAndLong)
        var purgeCache: Bool = false
        
        @Option(name: .shortAndLong)
        var location: String?

    }
}
