import ArgumentParser
import ColibriLibrary

extension Colibri.Create {
    struct Options: ParsableArguments, Locationable {
        
        // MARK: Properties
        
        @Option(name: .shortAndLong)
        var name: String
        
        @Option(name: .shortAndLong)
        var location: String?

    }
}
