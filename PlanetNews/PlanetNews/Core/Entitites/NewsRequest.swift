import Foundation

struct NewsRequest: Codable {
    var status: String
    var totalResults: Int
    var articles: [News]
}
