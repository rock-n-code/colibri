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
    
    // MARK: Computed
    
    var pathString: String {
        if #available(macOS 13.0, *) {
            path(percentEncoded: false)
        } else {
            path
        }
    }
    
    // MARK: Functions
    
    func appendingPath(_ path: String) -> URL {
        if #available(macOS 13.0, *) {
            appending(path: path)
        } else {
            appendingPathComponent(path)
        }
    }
    
}
