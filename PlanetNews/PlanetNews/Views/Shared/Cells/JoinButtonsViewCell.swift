import UIKit

class JoinButtonsViewCell: UITableViewCell {
    static let id = "\(JoinButtonsViewCell.self)"
    private var buttonStackView = UIStackView()
    var signInButton = WhiteButton(title: "", frame: .zero)
    var signUpButton = WhiteButton(title: "", frame: .zero)
    var signInDelegate: (() -> Void)?
    var signUpDelegate: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        buttonStackView.frame = FlexSize.rect(sample: CGRect(x: 0, y: 0, width: 338, height: 60))
        buttonStackView.backgroundColor = .clear
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .fill
        buttonStackView.spacing = FlexSize.height(60)
        buttonStackView.distribution = .fillEqually
        buttonStackView.addArrangedSubview(signInButton)
        buttonStackView.addArrangedSubview(signUpButton)
        signInButton.addTarget(self, action: #selector(self.didTouchSignInButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(self.didTouchSignUpButton), for: .touchUpInside)
        contentView.addSubview(buttonStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(signInTitle: String, signUpTitle: String) {
        signInButton.setTitle(signInTitle, for: .normal)
        signUpButton.setTitle(signUpTitle, for: .normal)
        buttonStackView.toHorizontalCenter(by: contentView)
    }
    
    @objc func didTouchSignInButton() {
        signInDelegate?()
    }
    
    @objc func didTouchSignUpButton() {
        signUpDelegate?()
    }
}
