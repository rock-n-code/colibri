import Foundation

@testable import ColibriLibrary

extension URL {
    
    // MARK: Constants
    
    static let someCurrentFolder = URL(at: "/some/current/folder")
    static let someDotFolder = URL(at: ".")
    static let someExistingFolder = URL(at: "/some/existing/folder")
    static let someExistingFile = URL(at: "/some/existing/file")
    static let someNewFolder = URL(at: "/some/new/folder")
    static let someNewFile = URL(at: "/some/new/file")
    static let someRandomURL = URL(string: "http://some.random.url")!
    static let someTildeFolder = URL(at: "~")
    
}
