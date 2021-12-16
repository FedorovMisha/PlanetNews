import UIKit

class FeedView: UIView, UITableViewDataSource, UITableViewDelegate {
    var data: [NewsModel] = []
    var nextPageDelegate: (() -> Void)?
    var isLoading = false
    var openNewsDelegate: ((String) -> Void)?
    lazy var headerView: UIView = {
        let view = UIView(frame: FlexSize.rect(sample: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 100)))
        let label = UILabel()
        label.text = TextConstants.feedViewTitle
        label.font = FontConstants.encodeSansBold.withSize(FlexSize.height(28))
        label.textColor = ColorConstants.white
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 38)
        ])
        return view
    }()
    
    
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
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: NewsViewCell.id)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func insertNews(news: [NewsModel]) {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsViewCell.id, for: indexPath) as! NewsViewCell
        cell.configure(news: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = data[indexPath.row]
        openNewsDelegate?(news.url)
    }
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.frame = UIScreen.main.bounds
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = headerView
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo:  bottomAnchor)
        ])
    }
}
