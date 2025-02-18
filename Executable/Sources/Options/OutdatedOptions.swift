import ArgumentParser
import ColibriLibrary

extension Colibri.Outdated {
    struct Options: ParsableArguments, Locationable {
        
        // MARK: Properties
        
        @Option(name: .shortAndLong)
        var location: String?
        
    }
}
