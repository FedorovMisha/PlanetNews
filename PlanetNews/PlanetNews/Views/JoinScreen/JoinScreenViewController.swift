import UIKit

class JoinScreenViewController: UIViewController {

    lazy var applicationTable: ApplicationTableView = {
        ApplicationTableView(headerView: HeaderView.shared, contentView: self.joinScreenView)
    }()
    
    lazy var joinScreenView: JoinScreenView = {
        JoinScreenView()
    }()
    
    var joinScreenViewModel = JoinScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(applicationTable)
        bind()
    }
    
    func bind() {
        joinScreenViewModel.navigationController = self.navigationController
        joinScreenView.didButtonTouchDelegate = joinScreenViewModel.buttonPressed(type:)
    }
}
