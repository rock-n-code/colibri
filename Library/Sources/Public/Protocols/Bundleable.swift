import Foundation

public protocol Bundleable {
    
    // MARK: Computed
    
    var resourcePath: String? { get }

    // MARK: Functions
    
    func url(forResource name: String?, withExtension ext: String?, subdirectory subpath: String?) -> URL?
    
}
