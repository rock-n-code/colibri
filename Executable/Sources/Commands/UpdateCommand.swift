import ArgumentParser
import ColibriLibrary

extension Colibri {
    struct Update: AsyncParsableCommand {
        
        // MARK: Properties
        
        static let configuration = CommandConfiguration(
            commandName: "update-dependencies",
            abstract: "Update package dependencies in a Hummingbird app",
            helpNames: .shortAndLong,
            aliases: ["update"]
        )
        
        @OptionGroup var options: Options
        
        // MARK: Functions
        
        mutating func run() async throws {
            let terminalService = TerminalService()

            let updateDependencies = UpdateDependenciesTask(terminalService: terminalService)
            
            try await updateDependencies(at: options.locationURL)
        }
        
    }
}
