enum Template: String {
    case app = "App/App"
    case appTests = "Test/AppTests"
    case package = "Package"
}

// MARK: - Properties

extension Template {
    
    // MARK: Computed
    
    var fileName: String {
        switch self {
        case .app: "App.swift"
        case .appTests: "AppTests.swift"
        case .package: "Package.swift"
        }
    }
    
    var filePath: String {
        folder.path + fileName
    }
    
    var folder: Folder {
        switch self {
        case .app: .app
        case .appTests: .testCasesPublic
        default: .root
        }
    }
    
}

// MARK: - CaseIterable

extension Template: CaseIterable {}
