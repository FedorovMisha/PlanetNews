import UIKit

class FlexSize {
    static let sampleWidth = 375.0
    static let sampleHeight = 815.0
    
    static func flexRectByScreen(_ rect: CGRect) -> CGRect {
        flexRectByAnotherRect(base: rect, by: UIScreen.main.bounds)
    }
    
    static func flexRectByAnotherRect(base: CGRect, by rect: CGRect) -> CGRect {
        let comparableWidth = Double(rect.width * Double(UIScreen.main.bounds.width).getNumberPercentage(sampleWidth))
        let comparableHeight = Double(rect.height * Double(UIScreen.main.bounds.height).getNumberPercentage(sampleHeight))
        let xMargin = rect.width * comparableWidth.getNumberPercentage(base.origin.x)
        let yMargin = rect.height * comparableHeight.getNumberPercentage(base.origin.y)
        let width = rect.width * comparableWidth.getNumberPercentage(base.width)
        let height = rect.height * comparableHeight.getNumberPercentage(base.height)
        return CGRect(x: xMargin, y: yMargin, width: width, height: height)
    }
    
    static func flexHeight(_ height: Double) -> Double {
        UIScreen.main.bounds.height * sampleHeight.getNumberPercentage(height)
    }
}
