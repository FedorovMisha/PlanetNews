import UIKit

class FeedViewController: UIViewController {

    lazy var applicationTable: ApplicationTableView = {
        ApplicationTableView(headerView: HeaderView.shared, contentView: FeedView())
    }()
    
    lazy var feedView: FeedView = {
        FeedView()
    }()
    
    var feedViewModel = FeedViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(applicationTable)
        bind()
        fetchNews()
    }
    
    func bind() {
        feedViewModel.onError = { [weak self] in
            print("Error")
        }
        
        feedViewModel.updateView = { [weak self] news in
            self?.feedView.insertNews(news: news)
        }
        
        feedView.nextPageDelegate = fetchNews
    }
    
    func fetchNews() {
        feedViewModel.fetchHeadlineNews()
    }
}
