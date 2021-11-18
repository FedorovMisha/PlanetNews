import UIKit

enum ContentCellTypes {
    case logo(height: Double),
         label(height: Double, name: String),
         button(height: Double, name: String),
         buttonStack(height: Double),
         textField(height: Double, name: String)
    
    var height: Double {
        switch self {
        case .logo(let height):
            return height
        case .label(let height, _):
            return height
        case .button(let height, _):
            return height
        case .buttonStack(let height):
            return height
        case .textField(let height, _):
            return height
        }
    }
}

class ContentTableViewCell: UITableViewCell {
    var tableView = UITableView()
    
    func configure() {
        selectionStyle = .none
        setupView()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.frame = self.bounds
        tableView.backgroundColor = .clear
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "\(ImageTableViewCell.self)")
        tableView.register(LabelTableViewCell.self, forCellReuseIdentifier: "\(LabelTableViewCell.self)")
        tableView.register(ButtonStackTableViewCell.self, forCellReuseIdentifier: "\(ButtonStackTableViewCell.self)")
        tableView.register(TextInputTableViewCell.self, forCellReuseIdentifier: "\(TextInputTableViewCell.self)")
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "\(ButtonTableViewCell.self)")
        self.contentView.addSubview(tableView)
    }
    
    func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        let cornerRadius = FlexSize.flexHeight(30)
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let shadow = CALayer()
        shadow.frame = contentView.bounds
        shadow.shadowColor = ShadowColors.baseContentShadow.cgColor
        shadow.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: cornerRadius).cgPath
        shadow.shadowOpacity = 1
        shadow.shadowRadius = 10
        shadow.shadowOffset = CGSize(width: 0, height: -4)
        shadow.zPosition = -10
        shadow.cornerRadius = cornerRadius - 10
        shadow.maskedCorners = contentView.layer.maskedCorners
        let bgLayer = CALayer()
        bgLayer.frame = contentView.bounds
        bgLayer.backgroundColor = BackgroundColors.baseContentDarkGray.cgColor
        bgLayer.zPosition = -9
        bgLayer.cornerRadius = contentView.layer.cornerRadius
        bgLayer.maskedCorners = contentView.layer.maskedCorners
        contentView.layer.addSublayer(shadow)
        contentView.layer.addSublayer(bgLayer)
    }
}
