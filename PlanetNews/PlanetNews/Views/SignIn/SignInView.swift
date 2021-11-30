import UIKit

class SignInView: UIView, UITableViewDataSource, UITableViewDelegate {
    var updateFieldDelegate: ((SignInViewModel.InputType, String) -> Void)?
    var submitDelegate: (() -> Void)?
    var backDelegate: (() -> Void)?
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
        let view = UIView(frame: FlexSize.rect(sample: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 200)))
        let label = UILabel(frame: FlexSize.rect(sample: CGRect(x: 137, y: 27, width: 120, height: 43)))
        label.toHorizontalCenter(by: self.tableView)
        label.text = "Login"
        label.textAlignment = .center
        label.font = FontConstants.encodeSansBold.withSize(FlexSize.height(28))
        label.textColor = ColorConstants.white
        view.addSubview(label)
        let imageView = UIImageView(image: ImageConstants.loginImage)
        imageView.frame = FlexSize.rect(sample: CGRect(x: 120, y: 100, width: 64, height: 64))
        let size = FlexSize.height(78)
        imageView.frame.size = CGSize(width: size, height: size)
        imageView.toHorizontalCenter(by: self.tableView)
        view.addSubview(imageView)
        return view
    }()
    
    
    var data:[SignInViewModel.CellType] = [
        .input(.email),
        .input(.password),
        .submitButton,
        .backButton
    ]
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        tableView.backgroundColor = .clear
        addSubview(tableView)
        tableView.tableHeaderView = headerView
        tableView.register(TextButtonViewCell.self, forCellReuseIdentifier: TextButtonViewCell.id)
        tableView.register(ButtonViewCell.self, forCellReuseIdentifier: ButtonViewCell.id)
        tableView.register(TextFieldViewCell.self, forCellReuseIdentifier: TextFieldViewCell.id)
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
    
    private func getCell(by type: SignInViewModel.CellType, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type.cellId, for: indexPath)
        
        switch type {
        case .input(let target):
            guard let cell = cell as? TextFieldViewCell else {
                fatalError()
            }
            cell.configure(by: target)
            cell.didEditingChangeDelegate = { [weak self] text in
                self?.updateFieldDelegate?(target, text)
            }
        case .submitButton:
            guard let cell = cell as? ButtonViewCell else {
                fatalError()
            }
            cell.configure(title: "Login")
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
        }
        return cell
    }
}
