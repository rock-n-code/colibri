public enum Artifact: String {
    case executable
    case image
}

// MARK: - Randomable

extension Artifact: Randomable {
    
    // MARK: Functions
    
    static func random() -> Artifact {
        .allCases.randomElement() ?? .executable
    }
    
}
