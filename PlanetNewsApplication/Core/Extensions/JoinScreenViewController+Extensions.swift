import UIKit

extension JoinScreenViewController {
    func makeLogo() -> UIImageView {
        let icon = UIImage(named: "planet_logo")
        let imageView = UIImageView(image: icon)
        imageView.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 54.67, h: 34.28)
        imageView.toHorizontalCenter(by: contentBox)
        return imageView
    }
    
    func makeHelloLabel() -> UILabel {
        let label = UILabel(frame: self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 85.6, h: 20.9))
        label.font = UIFont(name: FontNameDefaults.encodeSansBold, size: self.view.bounds.getPersentByRectHeight(persent: 3.44))
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Hey!\nAre you ready for new news?"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.toHorizontalCenter(by: contentBox)
        return label
    }
    
    func makeRuleText() -> UILabel {
        let label = UILabel(frame: self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 89.07, h: 6.35))
        label.text = " In order to continue using the application, you must\n log in"
        label.font = UIFont(name: FontNameDefaults.robotoRegular, size: self.view.bounds.getPersentByRectHeight(persent: 1.72))
        label.textColor = FontColors.baseGrayColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.toHorizontalCenter(by: contentBox)
        return label
    }
    
    func makeSignInButton() -> UIButton {
        let fontSize = self.view.bounds.getPersentByRectHeight(persent: 2.2)
        let button = UIButton(type: .system)
        button.layer.cornerRadius = self.contentBox.bounds.getPersentByRectHeight(persent: 4.18)
        button.backgroundColor = .white
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont(name: FontNameDefaults.robotoMedium, size: fontSize)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(self.onLoginClick), for: .touchUpInside)
        return button
    }
    
    func makeSignUpButton()  -> UIButton {
        let fontSize = self.view.bounds.getPersentByRectHeight(persent: 2.2)
        let button = UIButton(type: .system)
        button.layer.cornerRadius = self.contentBox.bounds.getPersentByRectHeight(persent: 4.18)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont(name: FontNameDefaults.robotoMedium, size: fontSize)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(self.onSignUpClick), for: .touchUpInside)
        return button
    }
    
    func makeButtonStack() -> UIStackView {
        let stack = UIStackView(frame: self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 90.13, h: 10.03))
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = self.contentBox.bounds.getPersentByRectHeight(persent: 6.35)
        stack.distribution = .fillEqually
        
        let items = [ self.loginButton, self.signUpButton]
        
        for btn in items{
            stack.addArrangedSubview(btn)
        }
        stack.toHorizontalCenter(by: contentBox)
        return stack
    }
}
