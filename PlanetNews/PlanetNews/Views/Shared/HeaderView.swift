import UIKit

class HeaderView: UIView {
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.frame = FlexSize.rect(sample: CGRect(x: 31, y: 83, width: 300, height: 100))
        let fontSize = FlexSize.height(36)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = ColorConstants.white
        label.font = FontConstants.encodeSansBold.withSize(fontSize)
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        label.frame = FlexSize.rect(sample: CGRect(x: 31, y: 62, width: 180, height: 21))
        label.textColor = ColorConstants.grayFont
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        let fontSize = FlexSize.height(18)
        label.font = FontConstants.robotoRegular.withSize(fontSize)
        return label
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = FlexSize.rect(sample: CGRect(x: 311, y: 51, width: 32, height: 32))
        let size = FlexSize.height(32)
        imageView.frame.size = CGSize(width: size, height: size)
        return imageView
    }()
    
    static var shared: HeaderView {
        let frame = FlexSize.rect(sample: CGRect(x: 0, y: 0, width: 375, height: 240))
        let headerView = HeaderView(mainText: TextConstants.joinScreenMainLabel,
                                    subText: TextConstants.joinScreenSubLabel,
                                    logo: ImageConstants.logo,
                                    frame: frame)
        return headerView
    }
    
    init(mainText: String, subText: String, logo: UIImage, frame: CGRect) {
        super.init(frame: frame)
        self.mainLabel.text = mainText
        self.subLabel.text = subText
        self.logoImageView.image = logo
        addSubview(mainLabel)
        addSubview(subLabel)
        addSubview(logoImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
