//
//  JoinVC.swift
//  PlanetNewsApplication
//
//  Created by Misha Fedorov on 22.10.2021.
//

import UIKit

class JoinVC: BaseVC {
    
    lazy var bigIcon:UIImageView = {
        let icon = UIImage(named: "planet_logo")
        let imageView = UIImageView(image: icon)
        imageView.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 22.67, yOffSet: 1.51, w: 54.67, h: 34.28)
        return imageView
    }()
    
    lazy var helloLabel: UILabel = {
        let label = UILabel(frame: self.contentBox.bounds.getSlicedRect(xOffSet: 7.2, yOffSet: 35.79, w: 85.6, h: 20.9))
        label.font = UIFont(name: FontNameDefaults.encodeSansBold, size: self.view.bounds.getPersentByRectHeight(persent: 3.44))
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Hey!\nAre you ready for new news?"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var ruleLabel: UILabel = {
        let label = UILabel(frame: self.contentBox.bounds.getSlicedRect(xOffSet: 5.07, yOffSet: 56.69, w: 89.07, h: 6.35))
        label.text = " In order to continue using the application, you must\n log in"
        label.font = UIFont(name: FontNameDefaults.robotoRegular, size: self.view.bounds.getPersentByRectHeight(persent: 1.72))
        label.textColor = FontColors.baseGrayColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = self.contentBox.bounds.getPersentByRectHeight(persent: 4.18)
        button.backgroundColor = .white
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(self.onLoginClick), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = self.contentBox.bounds.getPersentByRectHeight(persent: 4.18)
        button.backgroundColor = .white
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(self.onSignUpClick), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        var stack = UIStackView(frame: self.contentBox.bounds.getSlicedRect(xOffSet: 7.2, yOffSet: 66.39, w: 90.13, h: 10.03))
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = self.contentBox.bounds.getPersentByRectHeight(persent: 6.35)
        stack.distribution = .fillEqually
        
        var items = [ self.loginButton, self.signUpButton]
        
        for btn in items{
            stack.addArrangedSubview(btn)
        }
        
        return stack
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel(frame: self.contentBox.bounds.getSlicedRect(xOffSet: 21.6, yOffSet: 90.72, w: 56.8, h: 6.2))
        label.text = " Project for the discipline \n mobile development"
        label.font = UIFont(name: FontNameDefaults.robotoRegular, size: self.view.bounds.getPersentByRectHeight(persent: 1.72))
        label.textColor = FontColors.baseGrayColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainLabel.text = "News - find out everything"
        self.joinLabel.text = "Join our community"
        self.contentBox.addSubview(bigIcon)
        self.contentBox.addSubview(helloLabel)
        self.contentBox.addSubview(ruleLabel)
        self.contentBox.addSubview(buttonStackView)
        self.contentBox.addSubview(infoLabel)
    }
    
    
    @objc func onSignUpClick(){
        let signUp = SignUpVC()
        signUp.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
    @objc func onLoginClick(){
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}
