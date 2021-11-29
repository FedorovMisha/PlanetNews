import UIKit

class SignUpViewController: UIViewController {
    var signUpViewModel = SignUpViewModel()
    lazy var signUpView: SignUpView = {
        SignUpView()
    }()
    
    lazy var applicationTable: ApplicationTableView = {
        ApplicationTableView(headerView: HeaderView.shared, contentView: signUpView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(applicationTable)
        signUpView.propertyInfoDelegate = signUpViewModel.propertyInfo(by:)
        signUpView.updateFieldDelegate = signUpViewModel.updateField(by:text:)
        signUpView.submitDelegate = self.touchSignUpButton
        signUpView.backDelegate = self.touchBackButton
        
        signUpViewModel.failValidationDelegate = { [weak self] in
            self?.signUpViewModel.credentials.confirmPassword = ""
            self?.signUpView.tableView.reloadData()
        }
    }

    func touchSignUpButton() {
        signUpViewModel.signUp()
    }
    
    func touchBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
