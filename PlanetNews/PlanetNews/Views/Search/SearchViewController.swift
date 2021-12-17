import UIKit
import Kingfisher

class SearchViewController: UIViewController {

    lazy var applicationTable: ApplicationTableView = {
        return ApplicationTableView(headerView: self.headerView, contentView: self.searchView)
    }()
    
    lazy var headerView: HeaderView = {
        let headerTitle = TextConstants.searchViweHeaderTitle
        let headerSubTitle = TextConstants.searchViewHeaderSubTitle
        let frame = FlexSize.rect(sample: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 160))
        let headerView = HeaderView(mainText: headerTitle, subText: headerSubTitle, logo: ImageConstants.logo, frame: frame)
        headerView.mainLabel.sizeToFit()
        return headerView
    }()
    
    lazy var searchView = SearchView()
    
    let searchViewModel = SearchViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(applicationTable)
        bind()
        KingfisherManager.shared.setupKingfisher()
    }
    
    func bind() {
        searchViewModel.updateViewDataDelegate = { [weak self] news, isAppend in
            if isAppend {
                self?.searchView.insertNews(news: news)
            } else {
                self?.searchView.updateNews(news: news)
            }
        }
        searchViewModel.onError = {
            let alertVc = UIAlertController(title: ErrorMessages.newsEnded, message: nil, preferredStyle: .alert)
            alertVc.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alertVc, animated: true, completion: nil)
        }
        searchView.searchInput.searchDelegate = self.search(query:)
        searchView.nextPageDelegate = { [weak self] in
            self?.searchViewModel.findNext()
        }
        searchView.openNewsDelegate = openNews(url:)
        
    }
    
    func search(query: String) {
        searchViewModel.search(by: query)
    }
    
    func openNews(url: String) {
        let vc = NewsViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.url = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
