import UIKit

class FeedViewController: UIViewController {

    lazy var applicationTable: ApplicationTableView = {
        let headerView = HeaderView.shared
        headerView.mainLabel.text = TextConstants.feedViewHeaderTitle
        headerView.subLabel.text = TextConstants.feedViewHeaderSubTitle
        return ApplicationTableView(headerView: headerView, contentView: feedView)
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
            self.feedViewModel.fetchEverything { news in
                self.feedView.insertNews(news: news)
            }
        }
        
        feedView.openNewsDelegate = openNews(url:)
    }
    
    func openNews(url: String) {
        let vc = NewsViewController()
        vc.url = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
