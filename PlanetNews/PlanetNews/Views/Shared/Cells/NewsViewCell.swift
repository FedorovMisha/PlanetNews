import UIKit

class NewsViewCell: UITableViewCell {
    let pictureView = UIImageView()
    let title = UILabel()
    let source = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        addSubview(pictureView)
        addSubview(title)
        addSubview(source)
        configurePicture()
        configureSource()
        configureTitle()
    }
    
    func configureTitle() {
        title.textColor = ColorConstants.white
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.sizeToFit()
        NSLayoutConstraint.activate([
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 19),
            title.topAnchor.constraint(equalTo: topAnchor),
            title.rightAnchor.constraint(equalTo: pictureView.leftAnchor, constant: -10)
        ])
        
    }
    
    func configureSource() {
        source.textColor = ColorConstants.grayFont
        source.textAlignment = .left
        source.text = "Source"
        source.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            source.leftAnchor.constraint(equalTo: leftAnchor, constant: 19),
            source.rightAnchor.constraint(equalTo: pictureView.leftAnchor, constant: -10),
            source.bottomAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: -5)
        ])
    }
    
    func configurePicture() {
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        pictureView.layer.cornerRadius = 10
        pictureView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            pictureView.rightAnchor.constraint(equalTo: rightAnchor, constant: -19),
            pictureView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -19),
            pictureView.topAnchor.constraint(equalTo: topAnchor),
            pictureView.widthAnchor.constraint(equalToConstant: 140),
            pictureView.heightAnchor.constraint(equalToConstant: 105)
        ])
    }
    
    func configure(news: News) {
        title.text = news.title 
        guard let url = URL(string: news.urlToImage ?? ""), let data = try? Data(contentsOf: url) else {
            return
        }
        pictureView.image = UIImage(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
