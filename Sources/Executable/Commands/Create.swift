import ArgumentParser
import ColibriLibrary
import Foundation

extension Colibri {
    struct Create: AsyncParsableCommand {
        
        // MARK: Properties
        
        static let configuration = CommandConfiguration(
            commandName: "create-project",
            abstract: "Create a new, tailored Hummingbird app",
            helpNames: .shortAndLong,
            aliases: ["create"]
        )
        
        @OptionGroup var options: Options

        // MARK: Functions

        mutating func run() async throws {
            let fileService = FileService()
            let createRootFolder = CreateRootFolderTask(fileService: fileService)

            let rootFolder = try await createRootFolder(
                name: options.name,
                at: options.locationURL
            )

            print(rootFolder)
        }

    }
}

// MARK: - Options

extension Colibri.Create {
    struct Options: ParsableArguments {
     
        // MARK: Properties
        
        @Option(name: .shortAndLong)
        var name: String
        
        @Option(name: .shortAndLong)
        var location: String?
        
        // MARK: Computed
        
        var locationURL: URL? {
            location.flatMap { URL(fileURLWithPath: $0) }
        }

    }
}
