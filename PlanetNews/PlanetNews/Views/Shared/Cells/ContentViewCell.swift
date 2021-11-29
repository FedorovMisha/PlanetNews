import UIKit

class ContentViewCell: UITableViewCell {
    var usingView: UIView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func display(_ layer: CALayer) {
        super.display(layer)
    }
    
    func configure(use view: UIView) {
        guard usingView == nil else {
            return
        }
        usingView = view
        usingView?.frame = contentView.frame
        contentView.addSubview(view)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .clear
        let cornerRadius = FlexSize.height(30)
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let shadow = CALayer()
        shadow.frame = contentView.bounds
        shadow.shadowColor = ColorConstants.contentShadow.cgColor
        shadow.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: cornerRadius).cgPath
        shadow.shadowOpacity = 1
        shadow.shadowRadius = 10
        shadow.shadowOffset = CGSize(width: 0, height: -4)
        shadow.zPosition = -10
        shadow.cornerRadius = cornerRadius - 10
        shadow.maskedCorners = contentView.layer.maskedCorners
        let bgLayer = CALayer()
        bgLayer.frame = contentView.bounds
        bgLayer.backgroundColor = ColorConstants.contenBackgroundGray.cgColor
        bgLayer.zPosition = -9
        bgLayer.cornerRadius = contentView.layer.cornerRadius
        bgLayer.maskedCorners = contentView.layer.maskedCorners
        contentView.layer.addSublayer(shadow)
        contentView.layer.addSublayer(bgLayer)
    }
}
