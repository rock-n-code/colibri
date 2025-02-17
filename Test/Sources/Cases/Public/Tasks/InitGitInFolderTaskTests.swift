import Foundation
import Testing

@testable import ColibriLibrary

struct InitGitInFolderTaskTests {

    // MARK: Functions tests

    @Test(arguments: [URL.someCurrentFolder, .someNewFolder, .someDotFolder, .someTildeFolder])
    func task(at rootFolder: URL) async throws {
        // GIVEN
        let terminalService = TerminalServiceSpy()
        
        let initGitInFolder = InitGitInFolderTask(terminalService: terminalService)
        
        // WHEN
        try await initGitInFolder(at: rootFolder)
        
        // THEN
        let executableURL = URL(at: "/usr/bin/git")
        let pathFolder = rootFolder.pathString

        #expect(terminalService.actions.count == 3)
        #expect(terminalService.actions[0] == .ran(executableURL, ["init", pathFolder]))
        #expect(terminalService.actions[1] == .ran(executableURL, ["-C", pathFolder, "add", "."]))
        #expect(terminalService.actions[2] == .ran(executableURL, ["-C", pathFolder, "commit", "-m", "Initial commit"]))
    }

}
