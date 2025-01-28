import Foundation

protocol Processable {
    
    // MARK: Properties
    
    var arguments: [String]? { get set }
    var executableURL: URL? { get set }
    var standardError: Any? { get set }
    var standardOutput: Any? { get set }
    var terminationHandler: (@Sendable (Process) -> Void)? { get set }
    
    // MARK: Functions
    
    func run() throws
    
}
