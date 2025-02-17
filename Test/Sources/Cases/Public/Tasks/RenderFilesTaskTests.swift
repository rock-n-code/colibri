import Foundation
import Testing

@testable import ColibriLibrary

struct RenderFilesTaskTests {

    @Test(arguments: [URL.someCurrentFolder], [Project(name: "Some name goes here...")])
    func task(at rootFolder: URL, with project: Project) async throws {
        // GIVEN
        let fileService = FileServiceSpy()
        let templateService = TemplateServiceSpy()
        
        let renderFiles = RenderFilesTask(fileService: fileService,
                                          templateService: templateService)

        // WHEN
        try await renderFiles(at: rootFolder, with: project)
        
        // THEN
        let fileData = Data()
        let templates = Template.allCases

        #expect(fileService.actions.count == 3)
        #expect(templateService.actions.count == 3)
        
        fileService.actions.enumerated().forEach { index, action in
            #expect(action == .fileCreated(rootFolder.appendingPath(templates[index].filePath), fileData))
        }

        templateService.actions.enumerated().forEach { index, action in
            if case let .rendered(object, template) = action {
                #expect(object as? Project == project)
                #expect(template == templates[index].rawValue)
            } else {
                Issue.record("Action should have been a case of the `TemplateServiceSpy.Action` enumeration.")
            }
        }
    }

}
