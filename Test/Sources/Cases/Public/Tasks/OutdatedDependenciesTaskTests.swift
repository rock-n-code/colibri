import Foundation
import Testing

@testable import ColibriLibrary

struct OutdatedDependenciesTaskTests {
    
    @Test(arguments: [nil, URL.someCurrentFolder])
    func task(at location: URL?) async throws {
        // GIVEN
        let terminalService = TerminalServiceSpy()
        let task = OutdatedDependenciesTask(terminalService: terminalService)
        
        // WHEN
        try await task(at: location)
        
        // THEN
        let executableURL = URL(at: "/usr/bin/swift")
        let arguments = if let location {
            ["package", "update", "--package-path", location.pathString, "--dry-run"]
        } else {
            ["package", "update", "--dry-run"]
        }
        
        #expect(terminalService.actions.count == 1)
        #expect(terminalService.actions[0] == .ran(executableURL, arguments))
    }
    
    @Test(arguments: [nil, URL.someCurrentFolder], [TerminalServiceError.unexpected, .output(""), .captured("")])
    func task(at location: URL?, throws error: TerminalServiceError) async throws {
        // GIVEN
        let terminalService = TerminalServiceMock(action: .error(error))
        let task = BuildProjectTask(terminalService: terminalService)
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await task(at: location)
        }
    }
    
}
