import Foundation
import Alamofire

class NewsApiService: NewsApiServiceProtocol {
    private var jsonManager: JsonManagerProtocol = JsonManager()
    
    func everything(by query: String?,
                    page: Int,
                    pageSize: Int,
                    completion: ((NewsRequest) -> Void)?,
                    onError: (() -> Void)?) {
        AF.request(NewsEndpoints.everything,
                   parameters: ["page":page,
                                "pageSize":pageSize,
                                "q": query ?? "",
                                "apiKey":NewsApiOrg.apiKey])
            .validate()
            .responseJSON { responseJson in
                switch responseJson.result {
                case .success:
                    guard let newsRequest = self.handleRequest(data: responseJson.data) else {
                        onError?()
                        return
                    }
                    completion?(newsRequest)
                case .failure:
                    onError?()
                }
            }
    }
    
    func headlines(by country: Countries,
                   page: Int,
                   pageSize: Int,
                   completion: ((NewsRequest) -> Void)?,
                   onError: (() -> Void)?) {
        AF.request(NewsEndpoints.headlines,
                   parameters: ["page": page,
                                "pageSize":pageSize,
                                "apiKey":NewsApiOrg.apiKey,
                                "country":country.rawValue])
            .responseJSON { responseJson in
                switch responseJson.result {
                case .success:
                    guard let newsRequest = self.handleRequest(data: responseJson.data) else {
                        onError?()
                        return
                    }
                    completion?(newsRequest)
                case .failure:
                    onError?()
                }
            }
    }
    
    func handleRequest(data: Data?) -> NewsRequest? {
        guard let data = data else {
            return nil
        }
        guard let body = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        return NewsRequest(from: body)
    }
}
