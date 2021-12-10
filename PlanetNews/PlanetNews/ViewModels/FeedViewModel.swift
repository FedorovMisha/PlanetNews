import Foundation

class FeedViewModel {
    var totalCount = 0
    var page = 1
    var pageSize = 10
    var newsApiService: NewsApiServiceProtocol = NewsApiService()
    var onError: (() -> Void)?
    var updateView: (([News])-> Void)?
    var country = Countries.ru
    
    func fetchHeadlineNews() {
        newsApiService.headlines(by: country, page: page, pageSize: pageSize, completion: { [weak self] request in
            self?.page += 1
            self?.totalCount = request.totalResults
            self?.updateView?(request.articles)
        }) { [weak self] in
            self?.onError?()
        }
    }
    
}
