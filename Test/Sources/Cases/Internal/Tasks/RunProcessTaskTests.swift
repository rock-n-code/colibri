import Foundation
import Testing

@testable import ColibriLibrary

struct RunProcessTaskTests {
    
    // MARK: Properties
    
    private var process: Process
    
    // MARK: Initialisers
    
    init() {
        self.process = Process()
    }

    // MARK: Functions tests
  
    @Test(arguments: [Argument.empty, Argument.listAllInFolder])
    func run(with arguments: [String]) async throws {
        // GIVEN
        var task = RunProcessTask(process: process)

        // WHEN
        let output = try await task(path: .ls, arguments: arguments)

        // THEN
        #expect(output.isEmpty == false)
    }
    
    @Test(arguments: zip([Argument.help, Argument.listAllInPWD], Throw.outputs))
    func runThrows(with arguments: [String], throws error: RunProcessError) async throws {
        // GIVEN
        var task = RunProcessTask(process: process)
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await task(path: .ls, arguments: arguments)
        }
    }

}

// MARK: - String+Constants

private extension String {
    static let ls = "/bin/ls"
}

// MARK: - Parameters

private extension RunProcessTaskTests {
    enum Argument {
        static let empty: [String] = []
        static let help: [String] = ["--help"]
        static let listAllInFolder: [String] = ["-la", "."]
        static let listAllInPWD: [String] = ["-la", "~"]
    }
    
    enum Throw {
        static let outputs: [RunProcessError] = [
            .output("ls: unrecognized option `--help\'\nusage: ls [-@ABCFGHILOPRSTUWXabcdefghiklmnopqrstuvwxy1%,] [--color=when] [-D format] [file ...]\n"),
            .output("ls: ~: No such file or directory\n")
        ]
    }
}
