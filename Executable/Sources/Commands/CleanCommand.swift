import ArgumentParser
import ColibriLibrary

extension Colibri {
    struct Clean: AsyncParsableCommand {
        
        // MARK: Properties
        
        static let configuration = CommandConfiguration(
            commandName: "clean-project",
            abstract: "Clean a Hummingbird app",
            helpNames: .shortAndLong,
            aliases: ["clean"]
        )
        
        @OptionGroup var options: Options
        
        // MARK: Functions
        
        mutating func run() async throws {
            let terminalService = TerminalService()
            
            let cleanProject = CleanProjectTask(terminalService: terminalService)

            try await cleanProject(at: options.locationURL,
                                   shouldReset: options.reset,
                                   purgeCache: options.purgeCache)
        }
        
    }
}
