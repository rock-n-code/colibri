import ArgumentParser

@main
struct Colibri: AsyncParsableCommand {
    
    // MARK: Properties

    static let configuration = CommandConfiguration(
        abstract: "The utility to manage your Hummingbird apps",
        subcommands: [
            Build.self,
            Create.self
        ],
        defaultSubcommand: Create.self
    )
    
}
