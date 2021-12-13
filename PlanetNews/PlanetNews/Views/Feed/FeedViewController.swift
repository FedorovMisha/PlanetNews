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
    }
    
    func bind() {
        feedViewModel.onError = {
            print("Error")
        }
        
        feedViewModel.updateView = { [weak self] news in
            self?.feedView.insertNews(news: news)
        }
        
        feedView.nextPageDelegate = {
            self.feedViewModel.fetchHeadlineNews { news in
                let oldCount = self.feedView.data.count
                self.feedView.data.append(contentsOf: news)
                DispatchQueue.main.async {
                    self.feedView.tableView.performBatchUpdates({
                        let indexes = (oldCount..<(oldCount + news.count)).map {
                            IndexPath(row: $0, section: 0)
                        }
                        self.feedView.tableView.insertRows(at: indexes, with: .automatic)
                        
                    }, completion: nil)
                }
            }
        }
    }
    
    func fetchNews() {
        feedViewModel.fetchHeadlineNews()
    }
}
