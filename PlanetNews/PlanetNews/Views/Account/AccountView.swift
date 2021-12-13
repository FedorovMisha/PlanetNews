import UIKit

class AccountView: UIView, UITableViewDataSource, UITableViewDelegate {
    var viewData: ApplicationUser? {
        didSet {
            self.accountHeaderView.setupName(viewData?.name)
        }
    }
    var data: [AccountViewModel.CellTypes] = [
        .name,
        .email
    ]
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    var accountHeaderView = AccountHeaderView(frame: FlexSize.rect(sample: CGRect(x: 0, y: 0, width: 375, height: 160)))
    
    init() {
        super.init(frame: .zero)
        tableView.register(UserPropertyViewCell.self, forCellReuseIdentifier: UserPropertyViewCell.id)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        getCell(by: data[indexPath.row], indexPath: indexPath)
    }
    
    private func getCell(by type: AccountViewModel.CellTypes, indexPath: IndexPath) -> UITableViewCell {
        guard let user = viewData else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: type.key, for: indexPath) as! UserPropertyViewCell
        cell.configure(by: type, user: user)
        return cell
    }
    
    private func setupTableView() {
        self.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor)
        ])
        tableView.tableHeaderView = accountHeaderView
    }
}
