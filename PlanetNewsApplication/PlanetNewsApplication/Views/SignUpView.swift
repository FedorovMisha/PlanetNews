import UIKit

class SignUpView: UIView, UITableViewDataSource, UITableViewDelegate {
    weak var signUpController: SignUpViewController?
    var baseView: BaseView!
    let data: [ContentCellTypes] = [
        .label(height: FlexSize.flexHeight(110), name: ""),
        .textField(height: FlexSize.flexHeight(70), name: "userName"),
        .textField(height: FlexSize.flexHeight(70), name: "email"),
        .textField(height: FlexSize.flexHeight(70), name: "password"),
        .textField(height: FlexSize.flexHeight(110), name: "confirmPassword"),
        .button(height: 80, name: "submit"),
        .button(height: 100, name: "back")
    ]
    var userNameInput: UITextField?
    var emailInput: UITextField?
    var passwordInput: UITextField?
    var confirmPasswordInput: UITextField?
    
    init(_ controller: SignUpViewController, frame: CGRect) {
        super.init(frame: frame)
        self.signUpController = controller
        baseView = BaseView(frame: frame, dataSource: self, tableDelegate: self)
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
        case .label:
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(LabelTableViewCell.self)", for: indexPath) as! LabelTableViewCell
            cell.configure(configureLabel(label:cell:))
            return cell
        case .button(_, "submit"):
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(ButtonTableViewCell.self)", for: indexPath) as! ButtonTableViewCell
            cell.configureAsSubmitButton("Sign up")
            cell.button.addTarget(signUpController, action: #selector(signUpController?.didTouchSignUp), for: .touchUpInside)
            return cell
        case .button(_, "back"):
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(ButtonTableViewCell.self)", for: indexPath) as! ButtonTableViewCell
            cell.configureAsBackButton("Back")
            cell.button.addTarget(signUpController, action: #selector(signUpController?.didTouchBackButton), for: .touchUpInside)
            return cell
        case .textField(_, "userName"):
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(TextInputTableViewCell.self)", for: indexPath) as! TextInputTableViewCell
            cell.configureCell("Name")
            userNameInput = cell.inputTextField
            cell.inputTextField.addTarget(signUpController, action: #selector(signUpController?.didNameInputEnd(_:)), for: .editingDidEnd)
            return cell
        case .textField(_, "email"):
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(TextInputTableViewCell.self)", for: indexPath) as! TextInputTableViewCell
            cell.configureCell("Email")
            emailInput = cell.inputTextField
            cell.inputTextField.addTarget(signUpController, action: #selector(signUpController?.didEmailEditingEnd(_:)), for: .editingDidEnd)
            return cell
        case .textField(_, "password"):
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(TextInputTableViewCell.self)", for: indexPath) as! TextInputTableViewCell
            cell.configureCell("Password", isSecure: true)
            passwordInput = cell.inputTextField
            cell.inputTextField.addTarget(signUpController, action: #selector(signUpController?.didPasswordInputEnd(_:)), for: .editingDidEnd)
            cell.inputTextField.addTarget(signUpController, action: #selector(signUpController?.didPasswordInputStart(_:)), for: .editingDidBegin)
            return cell
        case .textField(_, "confirmPassword"):
            let cell = contentTable.dequeueReusableCell(withIdentifier: "\(TextInputTableViewCell.self)", for: indexPath) as! TextInputTableViewCell
            cell.configureCell("Confirm password", isSecure: true)
            confirmPasswordInput = cell.inputTextField
            cell.inputTextField.addTarget(signUpController, action: #selector(signUpController?.didConfirmPasswordInputEnd(_:)), for: .editingDidEnd)
            return cell
        default:
            fatalError()
        }
    }
    
    private func configureLabel(label: UILabel, cell: UITableViewCell) {
        label.text = "Sign up"
        label.textColor = .white
        label.frame = FlexSize.flexRectByScreen(CGRect(x: 137, y: 27, width: 110, height: 50))
        label.toHorizontalCenter(by: cell.contentView)
        label.textAlignment = .center
        let fontSize = FlexSize.flexHeight(28)
        label.font = FontDefaults.encodeSansBold?.withSize(fontSize)
    }
}
