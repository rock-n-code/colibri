import ArgumentParser
import ColibriLibrary

extension Colibri.Open {
    struct Options: ParsableArguments, Locationable {
        
        // MARK: Properties
        
        @Option(name: .shortAndLong)
        var ide: IDE = .xcode
        
        @Option(name: .shortAndLong)
        var location: String?
        
    }
}
