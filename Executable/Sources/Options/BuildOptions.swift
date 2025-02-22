import ArgumentParser
import ColibriLibrary

extension Colibri.Build {
    struct Options: ParsableArguments, Locationable {
        
        // MARK: Properties
        
        @Option(name: .shortAndLong)
        var artifact: Artifact = .executable
        
        @Option(name: .shortAndLong)
        var location: String?

    }
}
