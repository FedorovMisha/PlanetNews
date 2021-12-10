import UIKit

struct Source: Codable {
    var id: String?
    var name: String
    
    init(id: String?, name: String) {
        self.id = id
        self.name = name
    }
    
    init?(from: [String: Any]) {
        guard let name = from["name"] as? String else {
            return nil
        }
        self.name = name
        self.id = from["id"] as? String
    }
}

struct News: Codable {
    
    var source: Source
    var author: String?
    var title: String
    var description: String
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String
    
    init(source: Source, author: String, title: String, description: String, url: String, urlToImage: String, publishedAt: String, content: String) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    init?(from: [String: Any]) {
        guard let source = from["source"] as? [String: Any],
              let title = from["title"] as? String,
              let description = from["description"] as? String,
              let url = from["url"] as? String,
              let publishedAt = from["publishedAt"] as? String,
              let content = from["content"] as? String,
              let s = Source(from: source) else {
                  return nil
              }
        self.author = from["author"] as? String
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = from["urlToImage"] as? String
        self.publishedAt = publishedAt
        self.content = content
        self.source = s
    }
}
