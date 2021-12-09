import UIKit

class FeedViewController: UIViewController {

    lazy var applicationTable: ApplicationTableView = {
        ApplicationTableView(headerView: HeaderView.shared, contentView: UIView())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(applicationTable)
    }

}
