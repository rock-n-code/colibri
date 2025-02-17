import ColibriLibrary
import Foundation
import Testing

struct TerminalServiceTests {
    
    // MARK: Properties
    
    private let spy = TerminalServiceSpy()
    
    // MARK: Functions

    @Test(arguments: [URL.someNewFile], [[], ["--example"], ["--example", "--more", "--etc"]])
    func run(with executableURL: URL, and arguments: [String]) async throws {
        // GIVEN
        let service = TerminalServiceMock(action: .run(executableURL, arguments), spy: spy)

        // WHEN
        let result = try await service.run(executableURL, arguments: arguments)
        
        // THEN
        #expect(result == .content)

        #expect(spy.actions.isEmpty == false)

        let action = try #require(spy.actions.last)
        
        #expect(action == .ran(executableURL, arguments))
    }
    
    @Test(arguments: [TerminalServiceError.unexpected, .captured("Some captured error"), .output("Some output error")])
    func run(throws error: TerminalServiceError) async throws {
        // GIVEN
        let service = TerminalServiceMock(action: .error(error), spy: spy)
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.run(URL.someNewFile, arguments: [])
        }
        
        #expect(spy.actions.isEmpty == true)
    }

}

// MARK: - String+Constants

private extension String {
    static let content = ""
}
