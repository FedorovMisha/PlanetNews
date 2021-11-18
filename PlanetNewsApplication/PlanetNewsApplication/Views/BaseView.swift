import UIKit

class BaseView: UIView {
    let headerCellId = "\(HeaderTableViewCell.self)"
    let contentCellId = "\(ContentTableViewCell.self)"
    let data: [BaseViewCellTypes] = [
        .headerView(height: FlexSize.flexHeight(215)),
        .contentView(height: FlexSize.flexHeight(597))
    ]
    var tableView = UITableView()
    var contentTableView: UITableView?
    var contentViewDataSource: UITableViewDataSource?
    var contentTableViewDelegate: UITableViewDelegate?
    
    init(frame: CGRect,
         dataSource: UITableViewDataSource,
         tableDelegate: UITableViewDelegate) {
        super.init(frame: frame)
        self.contentViewDataSource = dataSource
        self.contentTableViewDelegate = tableDelegate
        setupTableView()
        self.addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.backgroundColor = BackgroundColors.baseScreenDarkGray
        tableView.register(HeaderTableViewCell.self,
                           forCellReuseIdentifier: headerCellId)
        tableView.register(ContentTableViewCell.self, forCellReuseIdentifier: contentCellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.frame = self.frame
        tableView.isScrollEnabled = false
        addSubview(tableView)
    }
}

enum BaseViewCellTypes {
    case headerView(height: Double), contentView(height: Double)
    var height: Double {
        switch self {
        case .headerView(let height):
            return height
        case .contentView(let height):
            return height
        }
    }
}

extension BaseView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return data[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("base view")
        return getCellByType(data[indexPath.row], indexPath: indexPath)
    }
    
    func getCellByType(_ type: BaseViewCellTypes, indexPath: IndexPath) -> UITableViewCell {
        switch type {
        case .headerView:
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCellId, for: indexPath) as! HeaderTableViewCell
            cell.configure(labelText: "News - find out everything", subLabelText: "Join out community")
            return cell
        case .contentView:
            let cell = tableView.dequeueReusableCell(withIdentifier: contentCellId, for: indexPath) as! ContentTableViewCell
            contentTableView = cell.tableView
            cell.tableView.delegate = self.contentTableViewDelegate
            cell.tableView.dataSource = self.contentViewDataSource
            cell.configure()
            return cell
        }
    }
}
