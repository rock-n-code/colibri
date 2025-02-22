public enum IDE: String {
    case vscode
    case xcode
}

// MARK: - Randomable

extension IDE: Randomable {
    
    // MARK: Functions
    
    static func random() -> IDE {
        .allCases.randomElement() ?? .xcode
    }
    
}
