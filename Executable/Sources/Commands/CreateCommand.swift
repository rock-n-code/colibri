import ArgumentParser
import ColibriLibrary

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
            let templateService = try await TemplateService(templateFolder: "Files/Templates")
            let terminalService = TerminalService()

            let copyFiles = CopyFilesTask(fileService: fileService)
            let createFolders = CreateFoldersTask(fileService: fileService)
            let createRootFolder = CreateRootFolderTask(fileService: fileService)
            let initGitInFolder = InitGitInFolderTask(terminalService: terminalService)
            let renderFiles = RenderFilesTask(fileService: fileService,
                                              templateService: templateService)

            let rootFolder = try await createRootFolder(name: options.name,
                                                        at: options.locationURL)
            
            try await createFolders(at: rootFolder)
            try await copyFiles(to: rootFolder)
            try await renderFiles(at: rootFolder,
                                  with: Project(name: options.name))
            try await initGitInFolder(at: rootFolder)
        }

    }
}
