import Testing

@testable import ColibriLibrary

struct RandomableTest {

    @Test func random() {
        // GIVEN
        let allCases = TestRandomable.allCases

        // WHEN
        let random = TestRandomable.random()
        
        // THEN
        #expect(allCases.contains(random))
    }

}

// MARK: - Enumerations

enum TestRandomable: Randomable {
    case someCase
    case someOtherCase

    // MARK: Functions
    
    static func random() -> TestRandomable {
        .allCases.randomElement() ?? .someCase
    }
    
}
