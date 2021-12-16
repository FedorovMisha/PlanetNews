import Foundation
import Alamofire

class SearchViewModel {
    static let pageSize = 12
    let apiService = NewsApiService()
    var page = 1
    var queryTotalItems = 0
    var query = ""
    var updateViewDataDelegate: (([NewsModel], Bool) -> Void)?
    var onError: (() -> Void)?
    
    func search(by query: String) {
        reset()
        self.query = query
        apiService.everything(by: query, page: page, pageSize: Self.pageSize) { request in
            self.page += 1
            self.queryTotalItems = request.totalResults
            self.updateViewDataDelegate?(request.articles.map({NewsModel(from: $0)}), false)
        } onError: {
            self.onError?()
        }

    }
    
    func findNext() {
        if !(queryTotalItems > page * Self.pageSize && query.count > 0) {
            return
        }
        
        apiService.everything(by: query, page: page, pageSize: Self.pageSize) { request in
            self.page += 1
            self.updateViewDataDelegate?(request.articles.map({NewsModel(from: $0)}), true)
        } onError: {
            print("next page err")
        }

    }
    
    private func reset() {
        query = ""
        page = 1
        queryTotalItems = 0
    }
}
