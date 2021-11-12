import UIKit

class ContentView : UIView, UITableViewDataSource, UITableViewDelegate {
    let cellId = "String"
    lazy var tableView: UITableView = {
        let table = UITableView(frame: self.frame)
        table.frame.origin = .zero
        table.isScrollEnabled = true
        table.backgroundColor = .clear
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return table
    }()
    private var data: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return data[indexPath.row].frame.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.contentView.addSubview(data[indexPath.row])
        return cell
    }
    
    func appendView(_ view: UIView) {
        data.append(view)
        tableView.reloadData()
    }
    
    func addSeparator(_ height: Double) {
        appendView(UIView(frame: CGRect(x: 0, y: 0, width: 10, height: height)))
    }
    
    func setup() {
        self.layer.cornerRadius = 30
        self.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMinXMinYCorner]
        // draw shadow
        let shadow = CALayer()
        shadow.frame = self.bounds
        shadow.shadowColor = ShadowColors.baseContentShadow.cgColor
        shadow.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 30).cgPath
        shadow.shadowOpacity = 1
        shadow.shadowRadius = 13
        shadow.shadowOffset = CGSize(width: 0, height: -4)
        shadow.zPosition = -10
        shadow.cornerRadius = self.layer.cornerRadius
        shadow.maskedCorners = self.layer.maskedCorners
        
        // draw background
        
        let bgLayer = CALayer()
        bgLayer.frame = self.bounds
        bgLayer.backgroundColor = BackgroundColors.baseContentDarkGray.cgColor
        bgLayer.zPosition = -9
        bgLayer.cornerRadius = self.layer.cornerRadius
        bgLayer.maskedCorners = self.layer.maskedCorners
        
        self.layer.addSublayer(shadow)
        self.layer.addSublayer(bgLayer)
    }
}
