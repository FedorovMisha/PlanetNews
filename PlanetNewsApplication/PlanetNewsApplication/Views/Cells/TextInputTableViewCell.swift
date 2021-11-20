import UIKit

class TextInputTableViewCell: UITableViewCell {
    var inputTextField = UITextField()
    var placeHolder: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ placeholder: String, isSecure: Bool = false) {
        self.placeHolder = placeholder
        inputTextField.frame = FlexSize.flexRectByScreen(CGRect(x: 0, y: 0, width: 260, height: 29))
        inputTextField.toHorizontalCenter(by: self.contentView)
        inputTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: BackgroundColors.baseInputBorderGray])
        inputTextField.backgroundColor = .clear
        inputTextField.textColor = .white
        let underLine = CALayer()
        underLine.frame = CGRect(x: 0, y: self.inputTextField.bounds.height, width: self.inputTextField.bounds.width, height: 2)
        underLine.backgroundColor =  BackgroundColors.baseInputBorderGray.cgColor
        inputTextField.layer.addSublayer(underLine)
        inputTextField.isSecureTextEntry = isSecure
        inputTextField.toHorizontalCenter(by: self)
        inputTextField.rightViewMode = .always
        inputTextField.leftViewMode = .always
        inputTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 10))
        inputTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 10))
        inputTextField.font = FontDefaults.robotoMedium?.withSize(FlexSize.flexHeight(18))
        inputTextField.addTarget(self, action: #selector(onEditingChanged(_:)), for: .editingChanged)
        inputTextField.addTarget(self, action: #selector(onEditingStart(_:)), for: .editingDidBegin)

        contentView.addSubview(inputTextField)
    }
    
    @objc func onEditingChanged(_ textField: UITextField) {
        inputTextField.textColor = .white
    }
    
    @objc func onEditingStart(_ textField: UITextField) {
        inputTextField.attributedPlaceholder = NSAttributedString(string: inputTextField.placeholder ?? "None", attributes: [.foregroundColor: BackgroundColors.baseInputBorderGray])
    }
}
