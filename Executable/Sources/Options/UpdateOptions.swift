import ArgumentParser
import ColibriLibrary

extension Colibri.Update {
    struct Options: ParsableArguments, Locationable {
        
        // MARK: Properties
        
        @Option(name: .shortAndLong)
        var location: String?
        
    }
}
