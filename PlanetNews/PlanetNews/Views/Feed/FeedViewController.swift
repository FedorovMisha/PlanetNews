import UIKit
import Kingfisher

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
        KingfisherManager.shared.setupKingfisher()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        feedView.nextPageDelegate?()
    }
    
    func bind() {
        feedViewModel.onError = {
            let alertVc = UIAlertController(title: ErrorMessages.newsEnded, message: nil, preferredStyle: .alert)
            alertVc.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alertVc, animated: true, completion: nil)
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
