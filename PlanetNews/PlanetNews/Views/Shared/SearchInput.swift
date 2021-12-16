import UIKit

class SearchInput: UITextField, UITextFieldDelegate {
    let underline = CALayer()
    var searchDelegate: ((String) -> Void)?
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.delegate = self
        underline.frame = CGRect(x: 0, y: self.bounds.height - 2, width: self.frame.width, height: 2)
    }
    
    private func configureUI() {
        backgroundColor = .clear
        textColor = ColorConstants.white
        font = FontConstants.robotoMedium.withSize(FlexSize.height(18))
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor: ColorConstants.inputBorderGray])
        let rView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 24))
        let searchImage = UIImageView(frame: CGRect(x: 15, y: 0, width: 24, height: 24))
        searchImage.image = ImageConstants.searchImage
        rView.addSubview(searchImage)
        rightView = rView
        rightViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 24))
        leftViewMode = .always
        underline.backgroundColor = ColorConstants.inputBorderGray.cgColor
        self.layer.addSublayer(underline)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count > 0, !text.isEmpty else {
            return false
        }
        searchDelegate?(text)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var text = textField.text else {
            return true
        }
        text.append(string)
        if text.count > 0 && text.count % 3 == 0 {
            searchDelegate?(text)
        }
        return true
    }
}
