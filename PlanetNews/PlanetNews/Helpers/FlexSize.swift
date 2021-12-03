import UIKit

class FlexSize {
    static let sampleWidth = 375.0
    static let sampleHeight = 815.0
    
    static func rect(sample rect: CGRect) -> CGRect {
        self.rect(sample: rect, by: UIScreen.main.bounds)
    }
    
    static func rect(sample: CGRect, by rect: CGRect) -> CGRect {
        let comparableWidth = Double(rect.width * Double(UIScreen.main.bounds.width).getNumberPercentage(sampleWidth))
        let comparableHeight = Double(rect.height * Double(UIScreen.main.bounds.height).getNumberPercentage(sampleHeight))
        let xMargin = rect.width * comparableWidth.getNumberPercentage(sample.origin.x)
        let yMargin = rect.height * comparableHeight.getNumberPercentage(sample.origin.y)
        let width = rect.width * comparableWidth.getNumberPercentage(sample.width)
        let height = Double(rect.height) * comparableHeight.getNumberPercentage(sample.height)
        return CGRect(x: xMargin, y: yMargin, width: width, height: height)
    }
    
    static func height(_ height: Double) -> Double {
        UIScreen.main.bounds.height * sampleHeight.getNumberPercentage(height)
    }
}
