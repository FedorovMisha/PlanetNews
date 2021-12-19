import UIKit
import Alamofire
import Kingfisher

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KingfisherManager.shared.cache.memoryStorage.config.totalCostLimit = 400 * 1024 * 1024
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = getViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
    
    func getViewController() -> UIViewController {
        let userManager = UserManager()
        if userManager.currentUser == nil {
            let joinScreenController = JoinScreenViewController()
            let navigationController = UINavigationController(rootViewController: joinScreenController)
            navigationController.setNavigationBarHidden(true, animated: false)
            return navigationController
        }
        let vc = ApplicationTabBarController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

