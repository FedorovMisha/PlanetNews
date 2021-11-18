import UIKit

class ImageTableViewCell: UITableViewCell {
    var pictureView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.pictureView)
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ image: UIImage, rect: CGRect) {
        self.pictureView.frame = FlexSize.flexRectByAnotherRect(base: rect, by: self.bounds)
        self.pictureView.frame.size = CGSize(width: pictureView.frame.width, height: pictureView.frame.width)
        self.pictureView.image = image
    }
    
    func toHorizontalCenter() {
        self.pictureView.toHorizontalCenter(by: self)
    }
}
