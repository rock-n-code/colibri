import Foundation
import Testing

@testable import ColibriLibrary

struct OpenProjectTaskTests {
    
    @Test(arguments: [nil, URL.someCurrentFolder])
    func taskWithVSCodeIDE(at location: URL?) async throws {
        // GIVEN
        let terminalService = TerminalServiceSpy()
        let task = OpenProjectTask(terminalService: terminalService)
        
        // WHEN
        try await task(with: .vscode, at: location)
        
        // THEN
        let executableURL = URL(at: "/usr/local/bin/code")
        let arguments = [location?.pathString ?? "."]

        #expect(terminalService.actions.count == 1)
        #expect(terminalService.actions[0] == .ran(executableURL, arguments))
    }
    
    @Test(arguments: [nil, URL.someCurrentFolder])
    func taskWithXcodeIDE(at location: URL?) async throws {
        // GIVEN
        let terminalService = TerminalServiceSpy()
        let task = OpenProjectTask(terminalService: terminalService)
        
        // WHEN
        try await task(with: .xcode, at: location)
        
        // THEN
        let locationPath = location?.appendingPath("Package.swift").pathString ?? "Package.swift"
        let executableURL = URL(at: "/usr/bin/open")
        let arguments = ["-a", "Xcode", locationPath]
        
        #expect(terminalService.actions.count == 1)
        #expect(terminalService.actions[0] == .ran(executableURL, arguments))
    }
    
    @Test(arguments: [nil, URL.someCurrentFolder], [TerminalServiceError.unexpected, .output(""), .captured("")])
    func task(at location: URL?, throws error: TerminalServiceError) async throws {
        // GIVEN
        let terminalService = TerminalServiceMock(action: .error(error))
        let task = OpenProjectTask(terminalService: terminalService)
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await task(with: .random(), at: location)
        }
    }
    
}
