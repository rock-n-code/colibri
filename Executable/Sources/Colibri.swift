import ArgumentParser

@main
struct Colibri: AsyncParsableCommand {
    
    // MARK: Properties

    static let configuration = CommandConfiguration(
        abstract: "The utility to manage your Hummingbird apps",
        subcommands: [
            Build.self,
            Clean.self, 
            Create.self,
            Open.self, 
            Outdated.self,
            Update.self
        ],
        defaultSubcommand: Create.self
    )
    
}
