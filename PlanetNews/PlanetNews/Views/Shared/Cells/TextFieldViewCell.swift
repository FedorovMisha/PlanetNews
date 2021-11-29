import UIKit

class TextFieldViewCell: UITableViewCell {
    static let id = "\(TextFieldViewCell.self)"
    var textField = UITextField()
    var didEditingChangeDelegate: ((String) -> Void)?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        textField.font = FontConstants.robotoMedium.withSize(FlexSize.height(18))
        textField.backgroundColor = .clear
        textField.frame = FlexSize.rect(sample: CGRect(x: 0, y: 0, width: 260, height: 35))
        textField.textColor = .white
        let underline = CALayer()
        underline.frame = CGRect(x: 0, y: textField.frame.height, width: textField.frame.width, height: 2)
        underline.backgroundColor = ColorConstants.inputBorderGray.cgColor
        textField.layer.addSublayer(underline)
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        textField.rightViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        textField.leftViewMode = .always
        contentView.addSubview(textField)
        textField.addTarget(self, action: #selector(didTextFieldChanged(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(didEditingStart(_:)), for: .editingDidBegin)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textField.toHorizontalCenter(by: contentView)
    }
    
    func configure(placeholder: String, value: String, error: String?, isSecure: Bool) {
        textField.text = value
        textField.isSecureTextEntry = isSecure
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [.foregroundColor: error == nil ? ColorConstants.white: UIColor.systemRed])
        textField.textColor = error == nil ? .green: .red;
    }
    
    @objc func didEditingStart(_ textField: UITextField) {
        textField.textColor = .white
    }
    
    @objc func didTextFieldChanged(_ textField: UITextField) {
        didEditingChangeDelegate?(textField.text ?? "")
    }
}
