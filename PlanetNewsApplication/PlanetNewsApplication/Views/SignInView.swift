import UIKit

class SignInView: UIView, UITableViewDataSource, UITableViewDelegate {
    var signInController: SignInViewController?
    var baseView: BaseView!
    var emailInput: UITextField?
    var passwordInput: UITextField?
    let data: [ContentCellTypes] = [
        .label(height: FlexSize.flexHeight(80), name: "login"),
        .logo(height: FlexSize.flexHeight(100)),
        .textField(height: FlexSize.flexHeight(64), name: "email"),
        .textField(height: FlexSize.flexHeight(80), name: "password"),
        .button(height: FlexSize.flexHeight(80), name: "login"),
        .button(height: FlexSize.flexHeight(60), name: "back")
    ]
    
    init(_ controller: SignInViewController, frame: CGRect) {
        super.init(frame: frame)
        self.signInController = controller
        baseView = BaseView(frame: frame, dataSource: self, tableDelegate: self)
        self.addSubview(baseView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return data[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getContentCell(data[indexPath.row], indexPath: indexPath)
    }
    
    private func getContentCell(_ type: ContentCellTypes, indexPath: IndexPath) -> UITableViewCell {
        guard let contentTable = baseView.contentTableView else {
            return UITableViewCell()
        }
        
        switch type {
        case .label:
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(LabelTableViewCell.self)", for: indexPath) as! LabelTableViewCell
            cell.configure(configureLabel(label:cell:))
            return cell
        case .logo:
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(ImageTableViewCell.self)", for: indexPath) as! ImageTableViewCell
            cell.configure(ImageDefaults.loginImage, rect: CGRect(x: 154, y: 10, width: 68, height: 68))
            return cell
        case .textField(_, name: "email"):
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(TextInputTableViewCell.self)", for: indexPath) as! TextInputTableViewCell
            cell.configureCell("Email")
            emailInput = cell.inputTextField
            return cell
        case .textField(_, name: "password"):
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(TextInputTableViewCell.self)", for: indexPath) as! TextInputTableViewCell
            cell.configureCell("Password", isSecure: true)
            passwordInput = cell.inputTextField
            return cell
        case .button(_, name: "login"):
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(ButtonTableViewCell.self)", for: indexPath) as! ButtonTableViewCell
            cell.configureAsSubmitButton("Login")
            cell.button.addTarget(signInController, action: #selector(signInController?.didTouchSignInButton), for: .touchUpInside)
            return cell
        case .button(_, name: "back"):
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(ButtonTableViewCell.self)", for: indexPath) as! ButtonTableViewCell
            cell.configureAsBackButton("Back")
            cell.button.addTarget(signInController, action: #selector(signInController?.didTouchBackButton), for: .touchUpInside)
            return cell
        default:
            fatalError()
        }
    }
    
    private func configureLabel(label: UILabel, cell: UITableViewCell) {
        label.text = "Login"
        label.textColor = .white
        label.frame = FlexSize.flexRectByScreen(CGRect(x: 137, y: 27, width: 110, height: 50))
        label.toHorizontalCenter(by: cell.contentView)
        label.textAlignment = .center
        let fontSize = FlexSize.flexHeight(28)
        label.font = FontDefaults.encodeSansBold?.withSize(fontSize)
    }
}
