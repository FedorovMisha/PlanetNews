import UIKit

class JoinScreenViewModel {
    enum CellType {
        case info, buttons
        
        var key: String {
            switch self {
            case .info:
                return JoinScreenInfoViewCell.id
            case .buttons:
                return JoinButtonsViewCell.id
            }
        }
        
        var height: Double {
            switch self {
            case .info:
                return FlexSize.height(400)
            case .buttons:
                return FlexSize.height(60)
            }
        }
    }
    
    enum ButtonType {
        case signIn, signUp
    }
    
    var navigationController: UINavigationController?
    
    func buttonPressed(type: ButtonType) {
        let vc: UIViewController
        switch type {
        case .signIn:
            vc = SignInViewController()
        case .signUp:
            vc = SignUpViewController()
        }
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}
