import UIKit

class SearchView: UIView, UITableViewDelegate, UITableViewDataSource {
    let searchLabel = UILabel()
    let searchInput = SearchInput(placeholder: TextConstants.searchViewInputPlaceholder)
    var nextPageDelegate: (() -> Void)?
    var openNewsDelegate: ((String) -> Void)?
    var isLoading = false
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: NewsViewCell.id)
        return tableView
    }()
    
    private var data: [News] = []
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        
        self.addSubview(searchLabel)
        self.addSubview(searchInput)
        self.addSubview(tableView)
        configureTableView()
        configureLabel()
        configureSearchInput()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateNews(news: [News]) {
        DispatchQueue.main.async {
            self.data = news
            self.isLoading = false
            self.tableView.reloadData()
        }
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
        if indexPath.row >= data.count - 2 && !isLoading && data.count > 0 {
            nextPageDelegate?()
            isLoading = true
        }
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
    
    private func configureLabel() {
        searchLabel.text = TextConstants.searchViewTitle
        searchLabel.textColor = ColorConstants.white
        searchLabel.font = FontConstants.encodeSansBold.withSize(FlexSize.height(28))
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            searchLabel.heightAnchor.constraint(equalToConstant: 34),
            searchLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 28),
            searchLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -28)
        ])
    }
    
    private func configureSearchInput() {
        searchInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchInput.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 25),
            searchInput.heightAnchor.constraint(equalToConstant: 40),
            searchInput.leftAnchor.constraint(equalTo: leftAnchor, constant: 23),
            searchInput.rightAnchor.constraint(equalTo: rightAnchor, constant: -23)
        ])
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchInput.bottomAnchor, constant: 25),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
