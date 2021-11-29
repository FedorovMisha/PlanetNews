import UIKit

class ButtonViewCell: UITableViewCell {
    static let id = "\(ButtonViewCell.self)"
    var button = WhiteButton(title: "", frame: .zero)
    var buttonPressedDelegate: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        button.frame = CGRect(x: 0, y: 0, width: 320, height: 60)
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(didTouchButton), for: .touchUpInside)
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
