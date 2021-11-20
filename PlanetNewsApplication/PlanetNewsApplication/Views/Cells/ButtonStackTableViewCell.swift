import UIKit

class ButtonStackTableViewCell: UITableViewCell {
    var buttons: [UIButton]? = nil {
        didSet {
            buttons?.forEach {
                buttonStack.addArrangedSubview($0)
            }
        }
    }
    var buttonStack: UIStackView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        buttonStack = UIStackView(frame: FlexSize.flexRectByScreen(CGRect(x: 0, y: 10, width: 338, height: 60)))
        self.contentView.addSubview(buttonStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ buttons: UIButton...) {
        guard self.buttons == nil else { return }
        self.buttons = buttons
        buttonStack.backgroundColor = .clear
        buttonStack.axis = .horizontal
        buttonStack.alignment = .fill
        buttonStack.spacing = FlexSize.flexHeight(60)
        buttonStack.distribution = .fillEqually
        buttonStack.toHorizontalCenter(by: self.contentView)
    }
}
