import Foundation

extension Double {
    func toPersent() -> Double{
        return self / 100.0
    }
    
    func getNumberPercentage(_ another: Double) -> Double {
        ((another * 100) / self).toPersent()
    }
}
