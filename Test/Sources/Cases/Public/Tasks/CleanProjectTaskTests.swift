import Foundation
import Testing

@testable import ColibriLibrary

struct CleanProjectTaskTests {
    
    @Test(arguments: [nil, URL.someCurrentFolder])
    func task(at location: URL?) async throws {
        // GIVEN
        let terminalService = TerminalServiceSpy()
        let task = CleanProjectTask(terminalService: terminalService)
        
        // WHEN
        try await task(at: location)
        
        // THEN
        let executableURL = URL(at: "/usr/bin/swift")
        let arguments = if let location {
            ["package", "clean", "--package-path", location.pathString]
        } else {
            ["package", "clean"]
        }
        
        #expect(terminalService.actions.count == 1)
        #expect(terminalService.actions[0] == .ran(executableURL, arguments))
    }
    
    @Test(arguments: [nil, URL.someCurrentFolder])
    func taskWithReset(at location: URL?) async throws {
        // GIVEN
        let terminalService = TerminalServiceSpy()
        let task = CleanProjectTask(terminalService: terminalService)
        
        // WHEN
        try await task(at: location, shouldReset: true)
        
        // THEN
        let executableURL = URL(at: "/usr/bin/swift")

        var arguments = if let location {
            ["package", "clean", "--package-path", location.pathString]
        } else {
            ["package", "clean"]
        }
        
        #expect(terminalService.actions.count == 2)
        #expect(terminalService.actions[0] == .ran(executableURL, arguments))
        
        arguments.remove(at: 1)
        arguments.insert("reset", at: 1)
        
        #expect(terminalService.actions[1] == .ran(executableURL, arguments))
    }
    
    @Test(arguments: [nil, URL.someCurrentFolder])
    func taskWithPurgeCache(at location: URL?) async throws {
        // GIVEN
        let terminalService = TerminalServiceSpy()
        let task = CleanProjectTask(terminalService: terminalService)
        
        // WHEN
        try await task(at: location, purgeCache: true)
        
        // THEN
        let executableURL = URL(at: "/usr/bin/swift")
        
        var arguments = if let location {
            ["package", "clean", "--package-path", location.pathString]
        } else {
            ["package", "clean"]
        }
        
        #expect(terminalService.actions.count == 2)
        #expect(terminalService.actions[0] == .ran(executableURL, arguments))
        
        arguments.remove(at: 1)
        arguments.insert("purge-cache", at: 1)
        
        #expect(terminalService.actions[1] == .ran(executableURL, arguments))
    }
    
    @Test(arguments: [nil, URL.someCurrentFolder])
    func taskWithResetAndPurgeCache(at location: URL?) async throws {
        // GIVEN
        let terminalService = TerminalServiceSpy()
        let task = CleanProjectTask(terminalService: terminalService)
        
        // WHEN
        try await task(at: location, shouldReset: true, purgeCache: true)
        
        // THEN
        let executableURL = URL(at: "/usr/bin/swift")
        
        var arguments = if let location {
            ["package", "clean", "--package-path", location.pathString]
        } else {
            ["package", "clean"]
        }
        
        #expect(terminalService.actions.count == 3)
        #expect(terminalService.actions[0] == .ran(executableURL, arguments))
        
        arguments.remove(at: 1)
        arguments.insert("reset", at: 1)
        
        #expect(terminalService.actions[1] == .ran(executableURL, arguments))
        
        arguments.remove(at: 1)
        arguments.insert("purge-cache", at: 1)
        
        #expect(terminalService.actions[2] == .ran(executableURL, arguments))
    }
    
    @Test(arguments: [nil, URL.someCurrentFolder], [TerminalServiceError.unexpected, .output(""), .captured("")])
    func task(at location: URL?, throws error: TerminalServiceError) async throws {
        // GIVEN
        let terminalService = TerminalServiceMock(action: .error(error))
        let task = CleanProjectTask(terminalService: terminalService)
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await task(at: location, shouldReset: .random(), purgeCache: .random())
        }
    }
    
}
