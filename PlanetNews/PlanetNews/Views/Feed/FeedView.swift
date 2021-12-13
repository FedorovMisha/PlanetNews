import UIKit

class FeedView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var data: [News] = []
    var nextPageDelegate: (() -> Void)?
    var isLoading = false
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: "cell")
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func insertNews(news: [News]) {
        DispatchQueue.main.async {
            let oldCount = self.data.count
            self.data.append(contentsOf: news)
            let indexes = (oldCount..<(oldCount + news.count)).map { i in
                IndexPath(row: i, section: 0)
            }
            self.tableView.performBatchUpdates({
                self.tableView.insertRows(at: indexes, with: .automatic)
            }, completion: nil)
            self.isLoading = false
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= data.count - 2 && !isLoading {
                self.nextPageDelegate?()
                isLoading = true
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsViewCell
        cell.configure(news: data[indexPath.row])
        return cell
    }
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.frame = UIScreen.main.bounds
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo:  bottomAnchor)
        ])
    }
}
