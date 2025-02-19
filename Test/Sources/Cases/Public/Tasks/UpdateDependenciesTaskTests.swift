import Foundation
import Testing

@testable import ColibriLibrary

struct UpdateDependenciesTaskTests {
    
    @Test(arguments: [nil, URL.someCurrentFolder], [false, true])
    func task(at location: URL?, checkOutdated: Bool) async throws {
        // GIVEN
        let terminalService = TerminalServiceSpy()
        let task = UpdateDependenciesTask(terminalService: terminalService)
        
        // WHEN
        try await task(at: location, checkOutdated: checkOutdated)
        
        // THEN
        let executableURL = URL(at: "/usr/bin/swift")
        
        var arguments = if let location {
            ["package", "update", "--package-path", location.pathString]
        } else {
            ["package", "update"]
        }
        
        if checkOutdated {
            arguments.append("--dry-run")
        }
        
        #expect(terminalService.actions.count == 1)
        #expect(terminalService.actions[0] == .ran(executableURL, arguments))
    }
    
    @Test(arguments: [nil, URL.someCurrentFolder], [TerminalServiceError.unexpected, .output(""), .captured("")])
    func task(at location: URL?, throws error: TerminalServiceError) async throws {
        // GIVEN
        let terminalService = TerminalServiceMock(action: .error(error))
        let task = UpdateDependenciesTask(terminalService: terminalService)
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await task(at: location, checkOutdated: .random())
        }
    }
    
}
