import UIKit

class SignInViewController: UIViewController {

    lazy var applicationTable: ApplicationTableView = {
        ApplicationTableView(headerView: HeaderView.shared, contentView: signInView)
    }()
    
    lazy var signInView: SignInView = {
        SignInView()
    }()
    
    var signInViewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(applicationTable)
        bind()
    }
    
    func bind() {
        self.signInView.submitDelegate = self.didTouchSignInButton
        self.signInView.backDelegate = self.didTouchBackButton
        self.signInView.updateFieldDelegate = self.signInViewModel.updateField(by:text:)
        
        self.signInViewModel.successSignInDelegate = { [weak self] in
            let vc = ApplicationTabBarController()
            vc.modalPresentationStyle = .fullScreen
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        self.signInViewModel.failSignInDelegate = { [weak self] in
            let message = "User not exists\n OR \nIncorrect data"
            let vc = UIAlertController(title: "Fail login", message: message, preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
    func didTouchSignInButton() {
        self.signInViewModel.signIn()
    }
    
    func didTouchBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
