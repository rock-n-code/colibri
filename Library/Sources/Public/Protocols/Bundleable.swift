import Foundation

public protocol Bundleable {

    // MARK: Functions
    
    func url(forResource name: String?, withExtension ext: String?, subdirectory subpath: String?) -> URL?
    
}
