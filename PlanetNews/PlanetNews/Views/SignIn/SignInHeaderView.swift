import UIKit

class SignInHeaderView: UIView {
    lazy var label: UILabel = {
        let label = UILabel(frame: FlexSize.rect(sample: CGRect(x: 137, y: 27, width: 120, height: 43)))
        label.toHorizontalCenter(by: self)
        label.text = TextConstants.signInTitle
        label.textAlignment = .center
        label.font = FontConstants.encodeSansBold.withSize(FlexSize.height(28))
        label.textColor = ColorConstants.white
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: ImageConstants.loginImage)
        imageView.frame = FlexSize.rect(sample: CGRect(x: 120, y: 100, width: 64, height: 64))
        let size = FlexSize.height(78)
        imageView.frame.size = CGSize(width: size, height: size)
        imageView.toHorizontalCenter(by: self)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
