import UIKit

class BaseViewController : UIViewController {
    
    lazy var contentBox : ContentView = {
        let yOffSet = self.view.bounds.height * 27.toPersent()
        let view = ContentView(frame: self.view.bounds.getSlicedRect(xOffSet: 0,
                                                                     yOffSet: 27,
                                                                     w: 100,
                                                                     h: 73))
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
        self.view.addSubview(self.mainLabel)
        self.view.addSubview(joinLabel)
        self.view.addSubview(logoImage)
        self.view.addSubview(contentBox)
        print(view.bounds)
    }

    func createTextInput(placeHolder:String, secure:Bool, frame:CGRect) -> UITextField {
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
