import ArgumentParser
import ColibriLibrary

extension Colibri {
    struct Outdated: AsyncParsableCommand {
        
        // MARK: Properties
        
        static let configuration = CommandConfiguration(
            commandName: "outdated-dependencies",
            abstract: "Check for outdated package dependencies in a Hummingbird app",
            helpNames: .shortAndLong,
            aliases: ["outdated"]
        )
        
        @OptionGroup var options: Options
        
        // MARK: Functions
        
        mutating func run() async throws {
            let terminalService = TerminalService()
            
            let updateDependencies = UpdateDependenciesTask(terminalService: terminalService)
            
            try await updateDependencies(at: options.locationURL, checkOutdated: true)
        }

    }
}
