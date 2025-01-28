enum Folder {
    case app
    case libraryPublic
    case libraryInternal
    case root
    case testCasesPublic
    case testCasesInternal
    case testHelpers
}

// MARK: - Properties

extension Folder {
    
    // MARK: Computed
    
    var path: String {
        switch self {
        case .app: "App/Sources/"
        case .libraryPublic: "Library/Sources/Public/"
        case .libraryInternal: "Library/Sources/Internal/"
        case .root: ""
        case .testCasesPublic: "Test/Sources/Cases/Public/"
        case .testCasesInternal: "Test/Sources/Cases/Internal/"
        case .testHelpers: "Test/Sources/Helpers/"
        }
    }
    
}

// MARK: - CaseIterable

extension Folder: CaseIterable {
    
    // MARK: Properties
    
    static var allCases: [Folder] {[
        .app,
        .libraryPublic,
        .libraryInternal,
        .testCasesPublic,
        .testCasesInternal,
        .testHelpers
    ]}
    
    static var allCasesWithRoot: [Folder] { [.root] + Folder.allCases }
    
}
