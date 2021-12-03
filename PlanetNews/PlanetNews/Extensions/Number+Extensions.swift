import Foundation

extension Double {
    var persent: Double {
        self / 100.0
    }
    
    func getNumberPercentage(_ another: Double) -> Double {
        ((another * 100.0) / self).persent
    }
}
