//
//  JoinVC.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 21.10.2021.
//

import UIKit

class LoginVC: BaseVC {

    lazy var signUpLabel:UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: self.contentBox.bounds.width*0.5 - 125, y: 27, width: 250, height: 43)
        label.font = UIFont(name: FontNameDefaults.encodeSansBold, size: 28)
        label.textColor = .white
        label.text = "Sign Up"
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameInput:UITextField = {
        let frame = CGRect(x: self.view.bounds.width*0.5 - 130, y: 107, width: 260, height: 30)
        return createTextInput(placeHolder: "Name", secure: false, frame: frame)
    }()
    
    lazy var emailInput: UITextField = {
        let frame = CGRect(x: self.view.bounds.width*0.5 - 130, y: 170, width: 260, height: 30)
        return createTextInput(placeHolder: "Email", secure: false, frame: frame)
    }()
    
    lazy var passwordInput: UITextField = {
        let frame = CGRect(x: self.view.bounds.width*0.5 - 130, y: 234, width: 260, height: 30)
        return createTextInput(placeHolder: "Password", secure: true, frame: frame)
    }()
    
    lazy var confirmPasswordInput: UITextField = {
        let frame = CGRect(x: self.view.bounds.width*0.5 - 130, y: 298, width: 260, height: 30)
        return createTextInput(placeHolder: "Confirm Password", secure: true, frame: frame)
    }()
    
    lazy var submitButton : UIButton = {
        let btn = UIButton(frame: CGRect(x: self.view.bounds.width * 0.5 - 160, y: 392, width: 320, height: 60))
        btn.setTitle("SignUp", for: .normal)
        btn.setTitleColor( UIColor.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 25
        btn.titleLabel?.font = UIFont(name: FontNameDefaults.robotoMedium, size: 18)
        btn.addTarget(self, action: #selector(onSignUpClick), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var backButton : UIButton = {
        let btn = UIButton(frame: CGRect(x: self.view.bounds.width * 0.5 - 20, y: 468, width: 40, height: 21))
        btn.titleLabel?.font = UIFont(name: FontNameDefaults.robotoMedium, size: 18)
        btn.setTitle("back", for: .normal)
        btn.backgroundColor = .clear
        btn.titleLabel?.font = UIFont(name: FontNameDefaults.robotoMedium, size: 18)
        btn.setTitleColor(FontColors.baseGrayColor, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainLabel.text = "News - find out everything"
        self.joinLabel.text = "Join our community"
        self.contentBox.addSubview(signUpLabel)
        self.contentBox.addSubview(nameInput)
        self.contentBox.addSubview(emailInput)
        self.contentBox.addSubview(passwordInput)
        self.contentBox.addSubview(confirmPasswordInput)
        self.contentBox.addSubview(submitButton)
        self.contentBox.addSubview(backButton)
    }
    
    func createTextInput(placeHolder:String, secure:Bool, frame:CGRect) -> UITextField{
        let field = UITextField()
        field.frame = frame
        field.backgroundColor = .clear
        field.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor.white])
        
        field.textColor = .white
        field.isSecureTextEntry = secure
        field.font = UIFont(name: FontNameDefaults.robotoRegular, size: 18)
        let border = CALayer()
        border.frame = CGRect(x: 0, y: field.frame.height + 2, width: field.frame.width, height: 2)
        border.backgroundColor = BackgroundColors.baseInputBorderGray.cgColor
        field.layer.addSublayer(border)
        return field
    }
    
    @objc func onSignUpClick(){
        //TODO
        self.dismiss(animated: true){
            let vc = Test(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }

    }
}
