import UIKit

class AccountViewModel {
    enum CellTypes {
        case email, name
        
        var name: String {
            switch self {
            case .email:
                return "Email"
            case .name:
                return "Name"
            }
        }
        
        var key: String {
            UserPropertyViewCell.id
        }
    }
    
    private let userManager = UserManager()
    
    func getCurrentUser() -> ApplicationUser? {
        userManager.currentUser
    }
}
