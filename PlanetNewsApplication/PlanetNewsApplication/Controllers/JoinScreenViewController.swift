import UIKit

class JoinScreenViewController: BaseViewController {
    
    lazy var bigIcon:UIImageView = {
        makeLogo()
    }()
    
    lazy var helloLabel: UILabel = {
        makeHelloLabel()
    }()
    
    lazy var ruleLabel: UILabel = {
        makeRuleText()
    }()
    
    lazy var loginButton: UIButton = {
        makeSignInButton()
    }()
    
    lazy var signUpButton: UIButton = {
        makeSignUpButton()
    }()
    
    lazy var buttonStackView: UIStackView = {
        makeButtonStack()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.mainLabel.text = "News - find out everything"
        self.joinLabel.text = "Join our community"
        self.view.addSubview(contentBox)
        self.contentBox.appendView(UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 10)))
        self.contentBox.appendView(bigIcon)
        self.contentBox.appendView(helloLabel)
        self.contentBox.appendView(ruleLabel)
        self.contentBox.appendView(UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 40)))
        self.contentBox.appendView(buttonStackView)
    }
    
    @objc func onSignUpClick(){
        let signUp = SignUpViewController()
        signUp.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
    @objc func onLoginClick(){
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
