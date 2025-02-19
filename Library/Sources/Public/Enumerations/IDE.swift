public enum IDE: String {
    case vscode
    case xcode
}

// MARK: - Extension

extension IDE {
    
    // MARK: Functions
    
    static func random() -> IDE {
        .allCases.randomElement() ?? .xcode
    }
    
}

// MARK: - CaseIterable

extension IDE: CaseIterable {}
