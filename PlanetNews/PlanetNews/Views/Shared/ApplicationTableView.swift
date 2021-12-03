import UIKit

class ApplicationTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    let contentCellId = "\(ContentViewCell.self)"
    var headerView: UIView!
    var contentView: UIView!
    
    init(headerView: HeaderView, contentView: UIView) {
        super.init(frame: UIScreen.main.bounds, style: .plain)
        self.contentView = contentView
        self.headerView = headerView
        register(ContentViewCell.self, forCellReuseIdentifier: contentCellId)
        separatorStyle = .none
        delegate = self
        dataSource = self
        backgroundColor = ColorConstants.screenBackgroundGray
        contentInsetAdjustmentBehavior = .never
        isScrollEnabled = false
        self.tableHeaderView = self.headerView
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        FlexSize.height(597)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: contentCellId, for: indexPath) as? ContentViewCell else {
            fatalError()
        }
        cell.configure(use: contentView)
        return cell
    }
}
