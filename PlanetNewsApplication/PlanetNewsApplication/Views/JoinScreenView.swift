import UIKit

class JoinScreenView: UIView, UITableViewDataSource, UITableViewDelegate {
    weak var joinScreenViewController: JoinScreenViewController?
    var baseView: BaseView!
    let data: [ContentCellTypes] = [
        .logo(height: FlexSize.flexHeight(215)),
        .label(height: FlexSize.flexHeight(140), name: "main"),
        .label(height: FlexSize.flexHeight(70), name: "rule"),
        .buttonStack(height: FlexSize.flexHeight(60))
    ]
    init(controller: JoinScreenViewController,frame: CGRect) {
        super.init(frame: frame)
        baseView = BaseView(frame: frame,
                            dataSource: self,
                            tableDelegate: self)
        self.joinScreenViewController = controller
        self.addSubview(baseView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        data[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getContentCell(data[indexPath.row], indexPath: indexPath)
    }
    
    private func getContentCell(_ type: ContentCellTypes, indexPath: IndexPath) -> UITableViewCell {
        guard let contentTable = baseView.contentTableView else {
            return UITableViewCell()
        }
        switch type {
        case .logo:
            let imageCell = contentTable.dequeueReusableCell(withIdentifier: "\(ImageTableViewCell.self)",
                                                             for: indexPath) as! ImageTableViewCell
            imageCell.configure(ImageDefaults.logoImage, rect: CGRect(x: 85,
                                                                      y: 10,
                                                                      width: 205,
                                                                      height: 205))
            imageCell.pictureView.toHorizontalCenter(by: imageCell.contentView)
            return imageCell
        case .label(_, "main"):
            let labelCell = contentTable.dequeueReusableCell(withIdentifier: "\(LabelTableViewCell.self)",
                                                             for: indexPath) as! LabelTableViewCell
            labelCell.configure(self.configureLabel(label:cell:))
            return labelCell
        case .label(_, "rule"):
            let labelCell = contentTable.dequeueReusableCell(withIdentifier: "\(LabelTableViewCell.self)", for: indexPath) as! LabelTableViewCell
            labelCell.configure(self.configureRuleLabel(label:cell:))
            return labelCell
        case .buttonStack:
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(ButtonStackTableViewCell.self)",
                                                        for: indexPath) as! ButtonStackTableViewCell
            let loginButton = WhiteButton("Login", frame: CGRect(x: 0, y: 0, width: 150, height: 60))
            loginButton.addTarget(joinScreenViewController, action: #selector(joinScreenViewController?.didTouchLoginButton), for: .touchUpInside)
            let signUpButton = WhiteButton("Sign Up", frame: CGRect(x: 0, y: 0, width: 150, height: 60))
            signUpButton.addTarget(joinScreenViewController, action: #selector(joinScreenViewController?.didTouchSignUpButton), for: .touchUpInside)
            cell.configure(loginButton, signUpButton)
            return cell
        default:
            fatalError()
        }
    }
    
    private func configureLabel(label: UILabel, cell: UITableViewCell) {
        label.text = "Hey! \n Are you ready for new \n news?"
        label.textColor = .white
        label.textAlignment = .center
        label.frame = FlexSize.flexRectByScreen(CGRect(x: 27, y: 10, width: 321, height: 125))
        let fontSize = FlexSize.flexHeight(28)
        label.font = FontDefaults.encodeSansBold?.withSize(fontSize)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.toHorizontalCenter(by: cell.contentView)
    }
    
    private func configureRuleLabel(label: UILabel, cell: UITableViewCell) {
        label.text = "In order to continue using the application you must \n log in"
        label.textColor = FontColors.baseGrayColor
        label.textAlignment = .center
        label.frame = FlexSize.flexRectByScreen(CGRect(x: 27, y: 0, width: 334, height: 40))
        let fontSize = FlexSize.flexHeight(14)
        label.font = FontDefaults.robotoMedium?.withSize(fontSize)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.toHorizontalCenter(by: cell.contentView)
    }
}
