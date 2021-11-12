import UIKit

class LoginViewController: BaseViewController {

    lazy var loginLabel: UILabel = {
        makeLoginLabel()
    }()
    
    lazy var loginIcon: UIImageView = {
        makeLoginIcon()
    }()
    
    lazy var emailInput: UITextField = {
        makeEmailInput()
    }()
    
    lazy var passwordInput: UITextField = {
        makePasswordInput()
    }()
    
    lazy var submitButton : UIButton = {
        makeSubmitButton()
    }()
    
    lazy var backButton : UIButton = {
        makeBackButton()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.mainLabel.text = "News - find out everything"
        self.joinLabel.text = "Join our community"
        self.contentBox.addSeparator(30)
        self.contentBox.appendView(loginLabel)
        self.contentBox.addSeparator(18)
        self.contentBox.appendView(loginIcon)
        self.contentBox.addSeparator(28)
        self.contentBox.appendView(emailInput)
        self.contentBox.addSeparator(34)
        self.contentBox.appendView(passwordInput)
        self.contentBox.addSeparator(57)
        self.contentBox.appendView(submitButton)
        self.contentBox.addSeparator(40)
        self.contentBox.appendView(backButton)
    }
}


extension LoginViewController {
    
    var credentials: SignInCredentials {
        return SignInCredentials(email: emailInput.text ?? "", password: passwordInput.text ?? "")
    }
    
    var authorizationService: Authorization {
        let userManager = UserManagerService()
        return AuthorizationService(userManger: userManager)
    }
    
    @objc func didTouchLogin(){
        guard let email = emailInput.text, let password = passwordInput.text, EmailValidator(email: email).validate().success, PasswordValidator(password: password).validate().success else {
            let vc = UIAlertController(title: "Sign In Error", message: "Incorrect data", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(vc, animated: true, completion: nil)
            return
        }
        
        if authorizationService.signIn(SignInCredentials(email: email, password: password)){
            let vc = Test()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let alertVC = UIAlertController(title: "Sign In", message: "Sign in error! \n the user may not exist or the data was entered incorrectly", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    @objc func didTouchBack(){
        self.navigationController?.popToRootViewController(animated: true)
    }
}
