import UIKit

class UserPropertyViewCell: UITableViewCell {
    static let id = "\(UserPropertyViewCell.self)"
    let propertyNameLabel = UILabel()
    let properyValueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        configureNameLabel()
        configureValueLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(by type: AccountViewModel.CellTypes, user: ApplicationUser) {
        propertyNameLabel.text = type.name
        switch type {
        case .email:
            properyValueLabel.text = user.email
        case .name:
            properyValueLabel.text = user.name
        }
    }
    
    private func configureNameLabel() {
        addSubview(propertyNameLabel)
        propertyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            propertyNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 38),
            propertyNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
        ])
        propertyNameLabel.font = FontConstants.robotoBold.withSize(18)
        propertyNameLabel.textColor = ColorConstants.grayFont
    }
    
    private func configureValueLabel() {
        addSubview(properyValueLabel)
        properyValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            properyValueLabel.leftAnchor.constraint(equalTo: propertyNameLabel.leftAnchor, constant: 28),
            properyValueLabel.topAnchor.constraint(equalTo: propertyNameLabel.bottomAnchor, constant: 10),
            properyValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        properyValueLabel.font = FontConstants.robotoBold.withSize(18)
        properyValueLabel.textColor = ColorConstants.white
    }
}
