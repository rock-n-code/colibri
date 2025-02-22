import ArgumentParser
import ColibriLibrary

extension Colibri {
    struct Build: AsyncParsableCommand {
        
        // MARK: Properties

        static let configuration = CommandConfiguration(
            commandName: "build-project",
            abstract: "Build a Hummingbird app",
            helpNames: .shortAndLong,
            aliases: ["build"]
        )
        
        @OptionGroup var options: Options

        // MARK: Functions
        
        mutating func run() async throws {
            let terminalService = TerminalService()

            let buildArtifact = BuildArtifactTask(terminalService: terminalService)
            
            try await buildArtifact(options.artifact, at: options.locationURL)
        }

    }
}
