import UIKit

class Test: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = "This is test controller"
        addLogoutBtn()
    }
    
    func addLogoutBtn(){
        let btn = UIButton(type: .infoDark)
        btn.backgroundColor = .white
        btn.setTitle("LogOut", for: .normal)
        btn.frame = CGRect(origin: contentBox.center, size: CGSize(width: 100, height: 50))
        btn.addTarget(self, action: #selector(self.logOut), for: .touchUpInside)
        self.contentBox.addSubview(btn)
    }
    
    @objc func logOut(){
        let userManager = UserManagerService()
        
        let authService = AuthorizationService(userManger: userManager)
        authService.logOut()
        let jVc = JoinVC()
        jVc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(jVc, animated: true)
    }
}
