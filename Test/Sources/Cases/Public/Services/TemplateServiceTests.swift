import ColibriLibrary
import Foundation
import Testing

struct TemplateServiceTests {
    
    // MARK: Properties
    
    private let spy = TemplateServiceSpy()
    
    // MARK: Functions tests

    @Test(arguments: [String.content])
    func render(_ content: String) async throws {
        // GIVEN
        let service = TemplateServiceMock(action: .render(content), spy: spy)
        
        // WHEN
        let result = try await service.render([:], on: .template)
        
        // THEN
        #expect(result == content)

        #expect(spy.actions.isEmpty == false)
    }
    
    @Test(arguments: [TemplateServiceError.serviceNotInitialized, .resourcePathNotFound, .templateNotFound, .contentNotRendered])
    func render(throws error: TemplateServiceError) async throws {
        // GIVEN
        let service = TemplateServiceMock(action: .error(error), spy: spy)
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.render([:], on: .template)
        }
        
        #expect(spy.actions.isEmpty == true)
    }

}

// MARK: - String+Constants

private extension String {
    static let content = ""
    static let template = ""
}
