import UIKit

class SignUpView: UIView, UITableViewDataSource, UITableViewDelegate {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = FlexSize.rect(sample: CGRect(x: 0, y: 0, width: 375, height: 597))
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    lazy var headerView: UIView = {
        let view = UIView(frame: FlexSize.rect(sample: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 100)))
        let label = UILabel(frame: FlexSize.rect(sample: CGRect(x: 137, y: 27, width: 120, height: 43)))
        label.toHorizontalCenter(by: self.tableView)
        label.text = "Sign Up"
        label.font = FontConstants.encodeSansBold.withSize(FlexSize.height(28))
        label.textColor = ColorConstants.white
        view.addSubview(label)
        return view
    }()
    var submitDelegate: (() -> Void)?
    var backDelegate: (() -> Void)?
    var updateFieldDelegate: ((SignUpViewModel.InputTypes, String) -> Void)?
    var propertyInfoDelegate: ((SignUpViewModel.InputTypes) -> SignUpViewModel.PropertyInfo)?
    let data: [SignUpViewModel.CellType] = [
        .textInput(.name),
        .textInput(.email),
        .textInput(.password),
        .textInput(.confirmPassword),
        .submitButton,
        .backButton
    ]
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        addSubview(tableView)
        tableView.register(TextFieldViewCell.self, forCellReuseIdentifier: TextFieldViewCell.id)
        tableView.register(ButtonViewCell.self, forCellReuseIdentifier: ButtonViewCell.id)
        tableView.register(TextButtonViewCell.self, forCellReuseIdentifier: TextButtonViewCell.id)
        tableView.tableHeaderView = headerView
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
        return getCell(by: data[indexPath.row], indexPath: indexPath)
    }
    
    private func getCell(by type: SignUpViewModel.CellType, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type.cellId, for: indexPath)
        
        switch type {
        case .textInput(let target):
            guard let cell = cell as? TextFieldViewCell, let propetyInfo = propertyInfoDelegate?(target) else {
                fatalError()
            }
            cell.configure(placeholder: propetyInfo.placeholder, value: propetyInfo.value, error: propetyInfo.error, isSecure: propetyInfo.isSecure)
            print(cell.frame.width)
            print("HJasdf")
            cell.didEditingChangeDelegate = { [weak self] text in
                self?.updateFieldDelegate?(target, text)
            }
        case .submitButton:
            guard let cell = cell as? ButtonViewCell else {
                fatalError()
            }
            cell.configure(title: "Sign Up")
            cell.buttonPressedDelegate = { [weak self] in
                self?.submitDelegate?()
            }
        case .backButton:
            guard let cell = cell as? TextButtonViewCell else {
                fatalError()
            }
            cell.configure(title: "Back")
            cell.buttonPressedDelegate = { [weak self] in
                self?.backDelegate?()
            }
            break
        }
        
        return cell
    }
}
