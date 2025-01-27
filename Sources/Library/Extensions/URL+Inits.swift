import Foundation

extension URL {
    
    // MARK: Initialisers
    
    init(at filePath: String) {
        if #available(macOS 13.0, *) {
            self = URL(filePath: filePath)
        } else {
            self = URL(fileURLWithPath: filePath)
        }
    }
    
}
