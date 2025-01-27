import ArgumentParser
import ColibriLibrary

@main
struct Colibri: AsyncParsableCommand {
    
    // MARK: Properties

    static let configuration = CommandConfiguration(
        abstract: "The utility to manage your Hummingbird apps",
        subcommands: [Create.self]
    )
    
}
