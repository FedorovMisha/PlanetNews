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
        bind()
    }

    func bind() {
        signUpView.propertyInfoDelegate = signUpViewModel.propertyInfo(by:)
        signUpView.updateFieldDelegate = signUpViewModel.updateField(by:text:)
        signUpView.submitDelegate = self.touchSignUpButton
        signUpView.backDelegate = self.touchBackButton
        signUpViewModel.failSignUpDelegate = self.failSignUp
        signUpViewModel.failValidationDelegate = self.failValidation(state:)
        signUpViewModel.successSignUpDelegate = self.successSignUp(_:)
    }
    
    func touchSignUpButton() {
        signUpViewModel.signUp()
    }
    
    func touchBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func failValidation(state: [ValidationResult]) {
        self.signUpView.tableView.reloadData()
        self.signUpViewModel.credentials.confirmPassword = ""
        var message = ""
        state.forEach {
            if let error = $0.error {
                message.append(contentsOf: "\n \(error)")
            }
        }
        let alertVc = UIAlertController(title: TextConstants.signUpValidationFailTitle, message: message, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: TextConstants.signUpContinueButtonText, style: .cancel, handler: nil))
        self.present(alertVc, animated: true, completion: nil)
    }
    
    func failSignUp() {
        let alertVc = UIAlertController(title: TextConstants.signUpFailTitle, message: TextConstants.signUpFailMessage, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: TextConstants.signUpContinueButtonText, style: .cancel, handler: nil))
        self.present(alertVc, animated: true, completion: nil)
    }
    
    func successSignUp(_ user: ApplicationUser) {
        let alertVc = UIAlertController(title: "Hi, \(user.name)", message: TextConstants.signUpWelcomeMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: TextConstants.signUpContinueButtonText,
                                   style: .default) { [weak self] _ in
            let vc = ApplicationTabBarController()
            vc.modalPresentationStyle = .fullScreen
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        alertVc.addAction(action)
        self.present(alertVc, animated: true, completion: nil)
    }
}
