import Foundation

protocol JsonManagerProtocol {
    func serialize<T: Codable>(_ target: T) -> String?
    func desirialize<T:Codable>(_ json: String) -> T?
}
