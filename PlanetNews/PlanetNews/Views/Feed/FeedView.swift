import UIKit

class FeedView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var data: [News] = [
        News(source: Source(id: nil, name: "1"), author: "", title: "Title", description: "123", url: "", urlToImage: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg", publishedAt: "", content: ""),
        News(source: Source(id: nil, name: "1"), author: "", title: "123", description: "123", url: "", urlToImage: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg", publishedAt: "", content: ""),
        News(source: Source(id: nil, name: "1"), author: "", title: "123", description: "123", url: "", urlToImage: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg", publishedAt: "", content: "")
    ]
    var nextPageDelegate: (() -> Void)?
    
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
        self.data.append(contentsOf: news)
        self.tableView.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row >= data.count - 5 {
//
//            DispatchQueue.main.async {
//                self.nextPageDelegate?()
//            }
//        }
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("data count = \(data.count)")
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsViewCell
        cell.configure(news: data[indexPath.row])
        print("Add cell")
        return cell
    }
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo:  bottomAnchor)
        ])
    }
}
