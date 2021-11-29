import UIKit

class JoinScreenInfoViewCell: UITableViewCell {
    static let id = "\(JoinScreenInfoViewCell.self)"
    lazy var helloLabel: UILabel = {
        let label = UILabel()
        label.frame = FlexSize.rect(sample: CGRect(x: 0, y: 214, width: 321, height: 130))
        label.textColor = ColorConstants.white
        let fontSize = FlexSize.height(28)
        label.font = FontConstants.encodeSansBold.withSize(fontSize)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    lazy var ruleLabel: UILabel = {
        let label = UILabel()
        label.frame = FlexSize.rect(sample: CGRect(x: 0, y: 350, width: 334, height: 40))
        label.textColor = ColorConstants.grayFont
        let fontSize = FlexSize.height(14)
        label.font = FontConstants.robotoMedium.withSize(fontSize)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = FlexSize.rect(sample: CGRect(x: 0, y: 10, width: 205, height: 205))
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(helloLabel)
        contentView.addSubview(ruleLabel)
        contentView.addSubview(logoImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(helloText: String, ruleText: String, logo: UIImage) {
        helloLabel.text = helloText
        ruleLabel.text = ruleText
        logoImageView.image = logo
        helloLabel.toHorizontalCenter(by: contentView)
        ruleLabel.toHorizontalCenter(by: contentView)
        logoImageView.toHorizontalCenter(by: contentView)
    }
}
