import Foundation

enum Countries: String {
    case ru = "ru",
         ua = "ua"
}

protocol NewsApiServiceProtocol {
    func everything(by query: String?,
                    page: Int,
                    pageSize: Int,
                    completion: ((NewsRequest) -> Void)?,
                    onError: (() -> Void)?)
    func headlines(by country: Countries,
                   page: Int,
                   pageSize: Int,
                   completion: ((NewsRequest) -> Void)?,
                   onError: (() -> Void)?)
}
