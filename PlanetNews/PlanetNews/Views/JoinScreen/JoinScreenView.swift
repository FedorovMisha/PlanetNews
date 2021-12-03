import UIKit

class JoinScreenView: UIView, UITableViewDelegate, UITableViewDataSource {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = FlexSize.rect(sample: CGRect(x: 0, y: 0, width: 375, height: 597))
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    var data: [JoinScreenViewModel.CellType] = [.info, .buttons]
    var didButtonTouchDelegate: ((JoinScreenViewModel.ButtonType) -> Void)?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.addSubview(tableView)
        tableView.register(JoinScreenInfoViewCell.self, forCellReuseIdentifier: JoinScreenViewModel.CellType.info.key)
        tableView.register(JoinButtonsViewCell.self, forCellReuseIdentifier: JoinScreenViewModel.CellType.buttons.key)
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
        return getCell(by: data[indexPath.row], indexPath: indexPath)
    }
    
    private func getCell(by type: JoinScreenViewModel.CellType, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: type.key, for: indexPath)
        switch type {
        case .info:
            guard let cell = cell as? JoinScreenInfoViewCell else {
                fatalError()
            }
            cell.configure(helloText: TextConstants.joinScreenHelloLabel, ruleText: TextConstants.joinScreenRuleLabel, logo: ImageConstants.logo)
        case .buttons:
            guard let cell = cell as? JoinButtonsViewCell else {
                fatalError()
            }
            cell.configure(signInTitle: "Login", signUpTitle: "Sign Up")
            cell.signInDelegate = { [weak self] in
                self?.didButtonTouchDelegate?(.signIn)
            }
            cell.signUpDelegate = { [weak self] in
                self?.didButtonTouchDelegate?(.signUp)
            }
        }
        return cell
    }
}
