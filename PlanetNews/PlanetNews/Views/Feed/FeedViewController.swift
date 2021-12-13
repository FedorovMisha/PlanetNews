import UIKit

class FeedViewController: UIViewController {

    lazy var applicationTable: ApplicationTableView = {
        ApplicationTableView(headerView: HeaderView.shared, contentView: feedView)
    }()
    
    lazy var feedView: FeedView = {
        FeedView()
    }()
    
    var feedViewModel = FeedViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(applicationTable)
        bind()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feedView.nextPageDelegate?()
//        fetchNews()
    }
    
    func bind() {
        feedViewModel.onError = {
            print("Error")
        }
        
        feedViewModel.updateView = { [weak self] news in
            self?.feedView.insertNews(news: news)
        }
        
        feedView.nextPageDelegate = {
            self.feedViewModel.fetchEverything { news in
                self.feedView.insertNews(news: news)
            }
        }
    }
    
    func fetchNews() {
        feedViewModel.fetchHeadlineNews()
    }
}
