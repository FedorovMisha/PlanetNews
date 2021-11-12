import UIKit

extension LoginViewController {
    func makeLoginLabel() -> UILabel {
        let label = UILabel(frame: self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 27.2, h: 7.19))
        label.textColor = .white
        label.text = "Login"
        label.textAlignment = .center
        label.font = UIFont(name: FontNameDefaults.encodeSansBold, size: self.view.bounds.getPersentByRectHeight(persent: 3.44))
        label.toHorizontalCenter(by: contentBox)
        return label
    }
    
    func makeLoginIcon() -> UIImageView {
        let image = UIImage(named: "login_icon")
        let imageView = UIImageView(image: image)
        imageView.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 68, h: 68)
        let size = self.contentBox.bounds.getPersentByRectHeight(persent: 11.37)
        imageView.frame.size = CGSize(width: size, height: size)
        imageView.toHorizontalCenter(by: contentBox)
        return imageView
    }
    
    func makeEmailInput() -> UITextField {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 69.33, h: 5.02)
        let field = createTextInput(placeHolder: "Email", secure: false, frame: frame)
        field.toHorizontalCenter(by: contentBox)
        return field
    }
    
    func makePasswordInput() -> UITextField {
        let frame = self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 69.33, h: 5.02)
        let field = createTextInput(placeHolder: "Password", secure: true, frame: frame)
        field.toHorizontalCenter(by: contentBox)
        return field
    }
    
    func makeSubmitButton() -> UIButton {
        let btn = UIButton(type:.system)
        btn.frame = self.contentBox.bounds.getSlicedRect(xOffSet: 0, yOffSet: 0, w: 85.6, h: 10.03)
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor( UIColor.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = self.view.bounds.getPersentByRectHeight(persent: 3.68)
        btn.titleLabel?.font = UIFont(name: FontNameDefaults.robotoMedium, size: self.view.bounds.getPersentByRectHeight(persent: 2.21))
        btn.addTarget(self, action: #selector(self.didTouchLogin), for: UIControl.Event.touchUpInside)
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
