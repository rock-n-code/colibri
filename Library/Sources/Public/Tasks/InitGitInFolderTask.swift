import Foundation

public struct InitGitInFolderTask {

    // MARK: Initialisers
    
    public init() {}
    
    // MARK: Functions
    
    public func callAsFunction(at rootFolder: URL) async throws (RunProcessError) {
        let pathCommand = "/usr/bin/git"
        let pathFolder = rootFolder.pathString
        
        var gitInit = RunProcessTask(process: Process())
        var gitAdd = RunProcessTask(process: Process())
        var gitCommit = RunProcessTask(process: Process())
        
        try await gitInit(path: pathCommand, arguments: ["init", pathFolder])
        try await gitAdd(path: pathCommand, arguments: ["-C", pathFolder, "add", "."])
        try await gitCommit(path: pathCommand, arguments: ["-C", pathFolder, "commit", "-m", "Initial commit"])
    }
    
}
