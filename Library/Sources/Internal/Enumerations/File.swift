enum File: String {
    case app = "App"
    case appArguments = "AppArguments"
    case appBuilder = "AppBuilder"
    case appOptions = "AppOptions"
    case appTests = "AppTests"
    case dockerFile = "DockerFile"
    case dockerIgnore = "DockerIgnore"
    case environment = "Environment"
    case gitIgnore = "GitIgnore"
    case license = "License"
    case loggerLevel = "LoggerLevel"
    case package = "Package"
    case readme = "Readme"
    case testArguments = "TestArguments"
    
}

// MARK: - Properties

extension File {
    
    // MARK: Computed

    var fileName: String {
        switch self {
        case .app: "App.swift"
        case .appArguments: "AppArguments.swift"
        case .appBuilder: "AppBuilder.swift"
        case .appOptions: "AppOptions.swift"
        case .appTests: "AppTests.swift"
        case .dockerFile: "Dockerfile"
        case .dockerIgnore: ".dockerignore"
        case .environment: "Environment+Properties.swift"
        case .gitIgnore: ".gitignore"
        case .license: "LICENSE"
        case .loggerLevel: "LoggerLevel+Conformances.swift"
        case .readme: "README.md"
        case .package: "Package.swift"
        case .testArguments: "TestArguments.swift"
        }
    }
    
    var filePath: String {
        folder.path + fileName
    }
    
    var folder: Folder {
        switch self {
        case .app, .appOptions: .app
        case .appArguments, .appBuilder: .libraryPublic
        case .appTests: .testCasesPublic
        case .environment, .loggerLevel: .libraryInternal
        case .testArguments: .testHelpers
        default: .root
        }
    }
    
    var resourcePath: String {
        let basePath = "Resources/Files/Sources"
        
        return switch self {
        case .app, .appOptions: "\(basePath)/App"
        case .appArguments, .appBuilder, .environment, .loggerLevel: "\(basePath)/Library"
        case .appTests, .testArguments: "\(basePath)/Test"
        default: basePath
        }
    }
    
}

// MARK: - CaseIterable

extension File: CaseIterable {}
