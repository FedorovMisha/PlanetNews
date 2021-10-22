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
        label.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 36.53, yOffSet: 4.52, w: 30, h: 7.2)
    
        label.font = UIFont(name: FontNameDefaults.encodeSansBold, size: self.view.bounds.getPersentByRectHeight(persent: 3.44))
        label.textColor = .white
        label.text = "Sign Up"
        label.textAlignment = .left
        return label
    }()
    
    lazy var nameInput:UITextField = {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 15.47, yOffSet: 17.89, w: 69.33, h: 5.02)
        return createTextInput(placeHolder: "Name", secure: false, frame: frame)
    }()
    
    lazy var emailInput: UITextField = {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 15.47, yOffSet: 28.43, w: 69.33, h: 5.02)
        return createTextInput(placeHolder: "Email", secure: false, frame: frame)
    }()
    
    lazy var passwordInput: UITextField = {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 15.47, yOffSet: 39.13, w: 69.33, h: 5.02)
        return createTextInput(placeHolder: "Password", secure: true, frame: frame)
    }()
    
    lazy var confirmPasswordInput: UITextField = {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 15.47, yOffSet: 49.83, w: 69.33, h: 5.02)
        return createTextInput(placeHolder: "Confirm Password", secure: true, frame: frame)
    }()
    
    lazy var submitButton : UIButton = {
        let btn = UIButton()
        btn.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 7.2, yOffSet: 65.55, w: 85.6, h: 10.03)
        btn.setTitle("SignUp", for: .normal)
        btn.setTitleColor( UIColor.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = self.view.bounds.getPersentByRectHeight(persent: 3.68)
        btn.titleLabel?.font = UIFont(name: FontNameDefaults.robotoMedium, size: self.view.bounds.getPersentByRectHeight(persent: 2.21))
        btn.addTarget(self, action: #selector(onSignUpClick), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    lazy var backButton : UIButton = {
        let btn = UIButton()
        btn.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 44.8, yOffSet: 78.26, w: 10.67, h: 3.52)
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
    
    
    @objc func onSignUpClick(){
        //TODO
        self.dismiss(animated: true){
            let vc = Test(nibName: nil, bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
}
