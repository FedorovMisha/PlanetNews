//
//  LoginVC.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 22.10.2021.
//

import UIKit

class LoginVC: BaseVC {

    lazy var loginLabel: UILabel = {
        let label = UILabel(frame: self.contentBox.bounds.getSlicedRect(xOffSet: 36.53, yOffSet: 5.02, w: 27.2, h: 7.19))
        label.textColor = .white
        label.text = "Login"
        label.textAlignment = .center
        label.font = UIFont(name: FontNameDefaults.encodeSansBold, size: self.view.bounds.getPersentByRectHeight(persent: 3.44))
        return label
    }()
    
    lazy var loginIcon: UIImageView = {
        let image = UIImage(named: "login_icon")
        let imageView = UIImageView(image: image)
        imageView.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 41.07, yOffSet: 15.22, w: 68, h: 68)
        let size = self.contentBox.bounds.getPersentByRectHeight(persent: 11.37)
        imageView.frame.size = CGSize(width: size, height: size)
        return imageView
    }()
    
    lazy var emailInput: UITextField = {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 15.47, yOffSet: 31.27, w: 69.33, h: 5.02)
        return createTextInput(placeHolder: "Email", secure: false, frame: frame)
    }()
    
    lazy var passwordInput: UITextField = {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 15.47, yOffSet: 41.97, w: 69.33, h: 5.02)
        return createTextInput(placeHolder: "Password", secure: true, frame: frame)
    }()
    
    lazy var submitButton : UIButton = {
        let btn = UIButton(type:.system)
        btn.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 7.2, yOffSet: 56.52, w: 85.6, h: 10.03)
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor( UIColor.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = self.view.bounds.getPersentByRectHeight(persent: 3.68)
        btn.titleLabel?.font = UIFont(name: FontNameDefaults.robotoMedium, size: self.view.bounds.getPersentByRectHeight(persent: 2.21))
        btn.addTarget(self, action: #selector(self.didTouchLogin), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var backButton : UIButton = {
        let fontSize = self.view.bounds.getPersentByRectHeight(persent: 2.2)
        let btn = UIButton(type: .system)
        btn.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 44.8, yOffSet: 69.57, w: 10.67, h: 3.52)
        btn.titleLabel?.font = UIFont(name: FontNameDefaults.robotoMedium, size: fontSize)
        btn.setTitle("back", for: .normal)
        btn.backgroundColor = .clear
        
        btn.setTitleColor(FontColors.baseGrayColor, for: .normal)
        btn.addTarget(self, action: #selector(self.didTouchBack), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainLabel.text = "News - find out everything"
        self.joinLabel.text = "Join our community"
        self.contentBox.addSubview(loginIcon)
        self.contentBox.addSubview(loginLabel)
        self.contentBox.addSubview(emailInput)
        self.contentBox.addSubview(passwordInput)
        self.contentBox.addSubview(submitButton)
        self.contentBox.addSubview(backButton)
    }
    
}


extension LoginVC {
    
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
