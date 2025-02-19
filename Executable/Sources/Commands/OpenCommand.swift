import ArgumentParser
import ColibriLibrary

extension Colibri {
    struct Open: AsyncParsableCommand {
        
        // MARK: Properties
        
        static let configuration = CommandConfiguration(
            commandName: "open-project",
            abstract: "Open a Hummingbird app",
            helpNames: .shortAndLong,
            aliases: ["open"]
        )
        
        @OptionGroup var options: Options
        
        // MARK: Functions
        
        mutating func run() async throws {
            let terminalService = TerminalService()
            
            let openProject = OpenProjectTask(terminalService: terminalService)
            
            try await openProject(with: options.ide, at: options.locationURL)
        }
        
    }
}
