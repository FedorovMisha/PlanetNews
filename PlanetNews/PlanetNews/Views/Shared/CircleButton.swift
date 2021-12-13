import UIKit

class CircleButton: UIButton {
    
    var picture = UIImageView()
    var didTapDelegate: (() -> Void)?
    
    init(image: UIImage) {
        super.init(frame: .zero)
        configureUI()
        picture.image = image
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        self.addTarget(self, action: #selector(didTouchDownButton), for: .touchDown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = bounds.height / 2
    }
    
    func configureUI() {
        self.layer.backgroundColor = ColorConstants.circleButtonBackground.cgColor
        addSubview(picture)
        picture.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picture.widthAnchor.constraint(equalToConstant: 24),
            picture.heightAnchor.constraint(equalToConstant: 24),
            picture.centerXAnchor.constraint(equalTo: centerXAnchor),
            picture.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    @objc func didTapButton() {
        self.didTapDelegate?()
        self.layer.backgroundColor = ColorConstants.circleButtonBackground.cgColor
    }
    
    @objc func didTouchDownButton() {
        self.layer.backgroundColor = ColorConstants.grayFont.cgColor
    }
}
