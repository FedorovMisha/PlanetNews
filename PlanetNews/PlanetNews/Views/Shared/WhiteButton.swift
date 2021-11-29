import UIKit

class WhiteButton: UIButton {
    init(title: String, frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 25
        titleLabel?.font = FontConstants.robotoMedium.withSize(FlexSize.height(18))
        setTitleColor(ColorConstants.contenBackgroundGray, for: .normal)
        setTitleColor(ColorConstants.clickedGray, for: .highlighted)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
