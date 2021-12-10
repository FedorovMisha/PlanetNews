import Foundation

class JsonManager: JsonManagerProtocol {
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    
    func serialize<T>(_ target: T) -> String? where T : Decodable, T : Encodable {
        guard let jsonData = try? jsonEncoder.encode(target) else {
            return nil
        }
        
        return String(data: jsonData, encoding: .utf8)
    }
    
    func desirialize<T>(_ json: String) -> T? where T : Decodable, T : Encodable {
        guard let data = json.data(using: .utf8) else {
            return nil
        }
        
        return try? jsonDecoder.decode(T.self, from: data)
    }
    
}
