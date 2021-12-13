import UIKit

class AccountViewController: UIViewController {

    lazy var applicationTable: ApplicationTableView = {
        ApplicationTableView(headerView: HeaderView.shared, contentView: self.accountView)
    }()
    
    lazy var accountView = AccountView()
    
    let viewModel = AccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        self.view.addSubview(applicationTable)
        self.setupUser()
    }
    
    func setupUser() {
        accountView.viewData = viewModel.getCurrentUser()
    }
}
