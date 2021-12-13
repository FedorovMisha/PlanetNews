import UIKit

class AccountHeaderView: UIView {
    var accountImageView = UIImageView(image: ImageConstants.accountImage)
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupName(_ name: String?) {
        label.text = "Hey, \(name ?? "User")!"
    }
    
    private func configureImageView() {
        addSubview(accountImageView)
        accountImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accountImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            accountImageView.topAnchor.constraint(equalTo: topAnchor, constant: 43),
            accountImageView.widthAnchor.constraint(equalToConstant: 64),
            accountImageView.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    private func configureLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 350),
            label.topAnchor.constraint(equalTo: accountImageView.bottomAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        label.textAlignment = .center
        label.font = FontConstants.robotoBold.withSize(28)
        label.textColor = ColorConstants.white
    }
}
