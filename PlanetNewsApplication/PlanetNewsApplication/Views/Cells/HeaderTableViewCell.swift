import UIKit

class HeaderTableViewCell: UITableViewCell {
    var logoImageView: UIImageView!
    var mainLabel: UILabel!
    var subLabel: UILabel!
    
    func configure(labelText: String, subLabelText: String) {
        selectionStyle = .none
        backgroundColor = .clear
        setupLogoImageView()
        setupMainLabel(labelText)
        setupSubLabel(subLabelText)
    }
    
    func setupLogoImageView() {
        logoImageView = UIImageView(image: ImageDefaults.logoImage)
        let baseRect = CGRect(x: 311, y: 51, width: 32, height: 32)
        logoImageView.frame = FlexSize.flexRectByAnotherRect(base: baseRect,
                                                             by: self.contentView.frame)
        let size = FlexSize.flexHeight(32)
        logoImageView.frame.size = CGSize(width: size, height: size)
        self.contentView.addSubview(logoImageView)
    }
    
    func setupMainLabel(_ text: String) {
        let baseRect = CGRect(x: 31, y: 83, width: 280, height: 90)
        mainLabel = UILabel(frame: FlexSize.flexRectByAnotherRect(base: baseRect, by: self.contentView.frame))
        mainLabel.text = text
        mainLabel.textColor = .white
        mainLabel.numberOfLines = 0
        mainLabel.lineBreakMode = .byWordWrapping
        let fontSize = FlexSize.flexHeight(36)
        mainLabel.font = FontDefaults.encodeSansBold?.withSize(fontSize)
        self.contentView.addSubview(mainLabel)
    }
    
    func setupSubLabel(_ text: String) {
        let baseRect = CGRect(x: 31, y: 62, width: 160, height: 21)
        subLabel = UILabel(frame: FlexSize.flexRectByAnotherRect(base: baseRect, by: self.contentView.frame))
        subLabel.text = text
        subLabel.textColor = FontColors.baseGrayColor
        subLabel.numberOfLines = 0
        subLabel.lineBreakMode = .byWordWrapping
        let fontSize = FlexSize.flexHeight(18)
        subLabel.font = FontDefaults.robotoRegular?.withSize(fontSize)
        self.contentView.addSubview(subLabel)
    }
}
