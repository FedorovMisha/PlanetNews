import UIKit

class BaseVC : UIViewController {

    override var shouldAutorotate: Bool {
        false
    }
    
    lazy var contentBox : UIView = {
        let yOffSet = self.view.bounds.height * 27.toPersent()
        let view = UIView()
        view.frame = self.view.bounds.getSlicedRect(xOffSet: 0, yOffSet: 27, w: 100, h: 73)
        
        return view
    }()
    
    lazy var mainLabel: UILabel = {
        let fontSize = self.view.bounds.getPersentByRectHeight(persent: 4.43)
        let label = UILabel()
        label.frame = self.view.bounds.getSlicedRect(xOffSet: 7.2, yOffSet: 10.2, w: 74.7, h: 11.1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.font = UIFont(name: FontNameDefaults.encodeSansBold, size: fontSize)
        return label
    }()
    
    lazy var joinLabel:UILabel = {
        let fontSize = self.view.bounds.getPersentByRectHeight(persent: 2.2)
        let label = UILabel()
        label.frame = self.view.bounds.getSlicedRect(xOffSet: 7.2, yOffSet: 7.6, w: 42.7, h: 2.6)
        label.textColor = FontColors.baseGrayColor
        
        label.font = UIFont(name: FontNameDefaults.robotoRegular, size: fontSize)
        return label
    }()
    
    lazy var logoImage: UIImageView = {
        let image = UIImage(named: "planet_logo")
        let view = UIImageView(image: image)
        view.frame = self.view.bounds.getSlicedRect(xOffSet: 82.93, yOffSet: 6.3, w: 8.53, h: 3.93)
        let size = self.view.bounds.getPersentByRectHeight(persent: 3.93)
        view.frame.size = CGSize(width: size, height: size)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackgroundColors.baseScreenDarkGray
        addContentBox()
        self.view.addSubview(self.mainLabel)
        self.view.addSubview(joinLabel)
        self.view.addSubview(logoImage)
        print(view.bounds)
    }

    private func addContentBox(){
        self.view.addSubview(self.contentBox)
        self.contentBox.backgroundColor = .clear
        self.contentBox.layer.cornerRadius = 30
        self.contentBox.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMinXMinYCorner]
        // draw shadow
        let shadow = CALayer()
        shadow.frame = self.contentBox.bounds
        shadow.shadowColor = ShadowColors.baseContentShadow.cgColor
        shadow.shadowPath = UIBezierPath(roundedRect: self.contentBox.bounds, cornerRadius: 30).cgPath
        shadow.shadowOpacity = 1
        shadow.shadowRadius = 13
        shadow.shadowOffset = CGSize(width: 0, height: -4)
        shadow.zPosition = -10
        shadow.cornerRadius = self.contentBox.layer.cornerRadius
        shadow.maskedCorners = self.contentBox.layer.maskedCorners
        
        // draw background
        
        let bgLayer = CALayer()
        bgLayer.frame = self.contentBox.bounds
        bgLayer.backgroundColor = BackgroundColors.baseContentDarkGray.cgColor
        bgLayer.zPosition = -9
        bgLayer.cornerRadius = self.contentBox.layer.cornerRadius
        bgLayer.maskedCorners = self.contentBox.layer.maskedCorners
        
        self.contentBox.layer.addSublayer(shadow)
        self.contentBox.layer.addSublayer(bgLayer)
    }

    func createTextInput(placeHolder:String, secure:Bool, frame:CGRect) -> UITextField{
        let field = UITextField()
        field.frame = frame
        field.backgroundColor = .clear
        field.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor.white])
        
        field.textColor = .white
        field.isSecureTextEntry = secure
        field.font = UIFont(name: FontNameDefaults.robotoMedium, size: self.view.bounds.getPersentByRectHeight(persent: 2.21))
        let border = CALayer()
        border.frame = CGRect(x: 0, y: field.frame.height + 2, width: field.frame.width, height: 2)
        border.backgroundColor = BackgroundColors.baseInputBorderGray.cgColor
        field.layer.addSublayer(border)
        return field
    }
}
