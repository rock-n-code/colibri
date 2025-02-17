enum File: String {
    case appArguments = "AppArguments"
    case appBuilder = "AppBuilder"
    case appOptions = "AppOptions"
    case dockerFile = "DockerFile"
    case dockerIgnore = "DockerIgnore"
    case environment = "Environment"
    case gitIgnore = "GitIgnore"
    case license = "License"
    case loggerLevel = "LoggerLevel"
    case readme = "Readme"
    case testArguments = "TestArguments"
    
}

// MARK: - Properties

extension File {
    
    // MARK: Computed

    var fileName: String {
        switch self {
        case .appArguments: "AppArguments.swift"
        case .appBuilder: "AppBuilder.swift"
        case .appOptions: "AppOptions.swift"
        case .dockerFile: "Dockerfile"
        case .dockerIgnore: ".dockerignore"
        case .environment: "Environment+Properties.swift"
        case .gitIgnore: ".gitignore"
        case .license: "LICENSE"
        case .loggerLevel: "LoggerLevel+Conformances.swift"
        case .readme: "README.md"
        case .testArguments: "TestArguments.swift"
        }
    }
    
    var filePath: String {
        folder.path + fileName
    }
    
    var folder: Folder {
        switch self {
        case .appOptions: .app
        case .appArguments, .appBuilder: .libraryPublic
        case .environment, .loggerLevel: .libraryInternal
        case .testArguments: .testHelpers
        default: .root
        }
    }
    
    var resourcePath: String {
        let basePath = "Resources/Files/Sources"
        
        return switch self {
        case .appOptions: "\(basePath)/App"
        case .appArguments, .appBuilder, .environment, .loggerLevel: "\(basePath)/Library"
        case .testArguments: "\(basePath)/Test"
        default: basePath
        }
    }
    
}

// MARK: - CaseIterable

extension File: CaseIterable {}
