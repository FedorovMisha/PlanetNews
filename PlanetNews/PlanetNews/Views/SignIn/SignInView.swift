import UIKit

class SignInView: UIView {
    var tableView = UITableView()
    init() {
        super.init(frame: UIScreen.main.bounds)
        tableView.backgroundColor = .clear
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
