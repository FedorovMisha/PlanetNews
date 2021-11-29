import UIKit

extension UIView {
    func toHorizontalCenter(by view: UIView) {
        self.frame.origin = CGPoint(x: view.center.x - self.frame.width * 0.5, y: self.frame.minY)
    }
}
