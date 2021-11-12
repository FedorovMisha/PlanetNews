import UIKit

extension SignUpViewController {
    func makeSignUpLabel() -> UILabel {
        let label = UILabel()
        label.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 30, h: 7.2)
        
        label.font = UIFont(name: FontNameDefaults.encodeSansBold, size: self.view.bounds.getPersentByRectHeight(persent: 3.44))
        label.textColor = .white
        label.text = "Sign Up"
        label.textAlignment = .left
        label.toHorizontalCenter(by: contentBox)
        return label
    }
    
    func makeNameInput() -> UITextField {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 69.33, h: 5.02)
        let textField = createTextInput(placeHolder: "Name", secure: false, frame: frame)
        textField.addTarget(self, action: #selector(self.didEditingStart(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(self.didNameInputEnd(_:)), for: .editingDidEnd)
        textField.toHorizontalCenter(by: contentBox)
        return textField
    }
    
    
    func makePasswordInput() -> UITextField {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 69.33, h: 5.02)
        let textField = createTextInput(placeHolder: "Password", secure: true, frame: frame)
        textField.addTarget(self, action: #selector(self.didEditingStart(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(self.didPasswordInputEnd(_:)), for: .editingDidEnd)
        textField.toHorizontalCenter(by: contentBox)
        return textField
    }
    
    
    func makeConfirmPasswordInput() -> UITextField {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 69.33, h: 5.02)
        let textField = createTextInput(placeHolder: "Confirm Password", secure: true, frame: frame)
        textField.addTarget(self, action: #selector(self.didEditingStart(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(self.didConfirmPasswordInputEnd(_:)), for: .editingDidEnd)
        textField.toHorizontalCenter(by: contentBox)
        return textField
    }
    
    
    func makeEmailInput() -> UITextField {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 69.33, h: 5.02)
        
        let textField = createTextInput(placeHolder: "Email", secure: false, frame: frame)
        textField.addTarget(self, action: #selector(self.didEditingStart(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(self.didEmailInputEnd(_:)), for: .editingDidEnd)
        textField.toHorizontalCenter(by: contentBox)
        return textField
    }
    
    func makeSubmitButton() -> UIButton {
        let btn = UIButton(type:.system)
        btn.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 85.6, h: 10.03)
        btn.setTitle("SignUp", for: .normal)
        btn.setTitleColor( UIColor.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = self.view.bounds.getPersentByRectHeight(persent: 3.68)
        btn.titleLabel?.font = UIFont(name: FontNameDefaults.robotoMedium, size: self.view.bounds.getPersentByRectHeight(persent: 2.21))
        btn.addTarget(self, action: #selector(didTouchSignUp), for: UIControl.Event.touchUpInside)
        btn.toHorizontalCenter(by: contentBox)
        return btn
    }
    
    func makeBackButton() -> UIButton {
        let fontSize = self.view.bounds.getPersentByRectHeight(persent: 2.2)
        let btn = UIButton(type: .system)
        btn.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 10.67, h: 3.52)
        btn.titleLabel?.font = UIFont(name: FontNameDefaults.robotoMedium, size: fontSize)
        btn.setTitle("back", for: .normal)
        btn.backgroundColor = .clear
        btn.setTitleColor(FontColors.baseGrayColor, for: .normal)
        btn.addTarget(self, action: #selector(self.didTouchBack), for: .touchUpInside)
        btn.toHorizontalCenter(by: contentBox)
        return btn
    }
}
