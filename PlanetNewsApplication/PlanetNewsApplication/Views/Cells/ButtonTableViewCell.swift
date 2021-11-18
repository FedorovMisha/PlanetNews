import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    var button: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAsSubmitButton(_ title: String) {
        button = WhiteButton(title, frame: FlexSize.flexRectByScreen(CGRect(x: 0, y: 0, width: 321, height: 60)))
        button.toHorizontalCenter(by: self.contentView)
        self.contentView.addSubview(button)
    }
    
    func configureAsBackButton(_ title: String) {
        button = UIButton(frame: FlexSize.flexRectByScreen(CGRect(x: 0, y: 0, width: 50, height: 30)))
        button.backgroundColor = .clear
        button.setTitle(title, for: .normal)
        button.setTitleColor(FontColors.baseGrayColor, for: .normal)
        button.setTitleColor(FontColors.baseClickedGrayColor, for: .highlighted)
        button.titleLabel?.font = FontDefaults.robotoBold?.withSize(FlexSize.flexHeight(18))
        button.toHorizontalCenter(by: self.contentView)
        self.contentView.addSubview(button)
    }
}
