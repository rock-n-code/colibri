import Foundation

public protocol Locationable {
    
    // MARK: Properties
    
    var location: String? { get set }
    
}

// MARK: - Locationable+Properties

public extension Locationable {
    
    // MARK: Properties
    
    var locationURL: URL? {
        location.flatMap { URL(fileURLWithPath: $0) }
    }
    
}
