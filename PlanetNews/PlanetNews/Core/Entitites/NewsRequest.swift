import Foundation

struct NewsRequest: Codable {
    var status: String
    var totalResults: Int
    var articles: [News] = []
    
    init?(from: [String:Any]) {
        guard let status = from["status"] as? String,
              let totalResults = from["totalResults"] as? Int, let articles = from["articles"] as? [[String:Any]]  else {
            return nil
        }
        
        self.status = status
        self.totalResults = totalResults
        self.articles = readArticles(from: articles)
    }
    
    func readArticles(from: [[String:Any]]) -> [News] {
        var result = [News]()
        
        for i in from {
            guard let news = News(from: i) else {
                continue
            }
            result.append(news)
        }
        return result
    }
    
}
