import UIKit

struct News: Codable {
    struct Source: Codable {
        var id: String?
        var name: String
    }
    
    var source: Source
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String
}
