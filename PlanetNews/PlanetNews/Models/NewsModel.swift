import UIKit
import Kingfisher

class NewsModel {
    var title = ""
    var urlToImage: String?
    var url = ""
    var sourceName = ""
    
    init(from: News) {
        self.title = from.title
        self.url = from.url
        self.sourceName = from.source.name
        self.urlToImage = from.urlToImage
    }
}
