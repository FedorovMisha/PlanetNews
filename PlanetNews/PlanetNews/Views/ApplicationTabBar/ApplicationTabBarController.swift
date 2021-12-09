import UIKit

class ApplicationTabBarController: UITabBarController {
    
    var homeButton = CircleButton(image: ImageConstants.homeImage)
    
    var searchButton = CircleButton(image: ImageConstants.searchImage)
    
    var accountButton = CircleButton(image: ImageConstants.accountImage)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTabBarUI()
        configure()
        configureButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size = CGSize(width: self.view.bounds.width, height: FlexSize.height(80))
        tabBar.frame.origin.y = view.frame.height - FlexSize.height(80)
    }
    
    func setupTabBarUI() {
        tabBar.layer.shadowColor = ColorConstants.contentShadow.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -4)
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shadowPath = UIBezierPath(rect: tabBar.bounds).cgPath
        tabBar.layer.shadowRadius = 4
        tabBar.backgroundColor = ColorConstants.contenBackgroundGray
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = .none
            appearance.shadowColor = .clear
            tabBar.standardAppearance = appearance
        }
    }
    
    func configureButtons() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = FlexSize.height(60)
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        tabBar.addSubview(stackView)
        stackView.addArrangedSubview(homeButton)
        stackView.addArrangedSubview(searchButton)
        stackView.addArrangedSubview(accountButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: 6),
            stackView.heightAnchor.constraint(equalToConstant: 58),
            stackView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func configure() {
        let feedVC = FeedViewController()
        let feedNavVC = UINavigationController(rootViewController: feedVC)
        
        let searchVC = SearchViewController()
        let searchNavVC = UINavigationController(rootViewController: searchVC)
        
        let accountVC = AccountViewController()
        let accountNavVC = UINavigationController(rootViewController: accountVC)
        
        homeButton.didTapDelegate = {[weak self] in
            self?.selectedIndex = 0
        }
        
        searchButton.didTapDelegate = {[weak self] in
            self?.selectedIndex = 1
        }
        
        accountButton.didTapDelegate = {[weak self] in
            self?.selectedIndex = 2
        }
        
        viewControllers = [
            feedNavVC,
            searchNavVC,
            accountNavVC
        ]
    }
}
