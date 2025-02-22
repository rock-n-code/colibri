import Foundation
import Testing

@testable import ColibriLibrary

struct BuildArtifactTaskTests {

    @Test(arguments: [nil, URL.someCurrentFolder])
    func taskForExecutable(at location: URL?) async throws {
        // GIVEN
        let terminalService = TerminalServiceSpy()
        let task = BuildArtifactTask(terminalService: terminalService)

        // WHEN
        try await task(.executable, at: location)

        // THEN
        let executableURL = URL(at: "/usr/bin/swift")
        let arguments = if let location {
            ["build", "--package-path", location.pathString]
        } else {
            ["build"]
        }
        
        #expect(terminalService.actions.count == 1)
        #expect(terminalService.actions[0] == .ran(executableURL, arguments))
    }
    
    @Test(arguments: [nil, URL.someCurrentFolder])
    func taskForImage(at location: URL?) async throws {
        // GIVEN
        let terminalService = TerminalServiceSpy()
        let task = BuildArtifactTask(terminalService: terminalService)
        
        // WHEN
        try await task(.image, at: location)
        
        // THEN
        let executableURL = URL(at: "/usr/local/bin/docker")
        let arguments = if let location {
            ["compose", "--project-directory", location.pathString, "build"]
        } else {
            ["compose", "build"]
        }
        
        #expect(terminalService.actions.count == 1)
        #expect(terminalService.actions[0] == .ran(executableURL, arguments))
    }
    
    @Test(arguments: [nil, URL.someCurrentFolder], [TerminalServiceError.unexpected, .output(""), .captured("")])
    func taskForArtifact(at location: URL?, throws error: TerminalServiceError) async throws {
        // GIVEN
        let terminalService = TerminalServiceMock(action: .error(error))
        let task = BuildArtifactTask(terminalService: terminalService)

        // WHEN
        // THEN
        await #expect(throws: error) {
            try await task(.random(), at: location)
        }
    }

}
