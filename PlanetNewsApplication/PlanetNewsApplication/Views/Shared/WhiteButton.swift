import UIKit

class WhiteButton: UIButton {
    init(_ title: String, frame: CGRect) {
        super.init(frame: frame)
        self.setTitle(title, for: .normal)
        self.backgroundColor = .white
        let fontSize = FlexSize.flexHeight(18)
        self.titleLabel?.font = FontDefaults.robotoMedium?.withSize(fontSize)
        self.setTitleColor(BackgroundColors.baseContentDarkGray, for: .normal)
        self.setTitleColor(FontColors.baseGrayColor, for: .highlighted)
        self.layer.cornerRadius = FlexSize.flexHeight(25)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
