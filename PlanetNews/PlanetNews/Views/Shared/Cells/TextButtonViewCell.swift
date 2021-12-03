import UIKit

class TextButtonViewCell: UITableViewCell {
    static let id = "\(TextButtonViewCell.self)"
    var button = UIButton(type: .system)
    var buttonPressedDelegate: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 60)
        contentView.addSubview(button)
        button.titleLabel?.font = FontConstants.robotoMedium.withSize(FlexSize.height(18))
        button.addTarget(self, action: #selector(didTouchButton), for: .touchUpInside)
        button.setTitleColor(ColorConstants.grayFont, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.toHorizontalCenter(by: contentView)
    }
    
    func configure(title: String) {
        button.setTitle(title, for: .normal)
    }
    
    @objc func didTouchButton() {
        buttonPressedDelegate?()
    }

}
