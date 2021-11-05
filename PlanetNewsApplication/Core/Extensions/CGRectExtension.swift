import UIKit

extension CGRect{
    func getSlicedRect(xOffSet: Double,yOffSet:Double, w:Double, h:Double) -> CGRect{
        let yMargin = self.height * yOffSet.toPersent()
        let xMargin = self.width * xOffSet.toPersent()
        let x = self.width * w.toPersent()
        let y = self.height * h.toPersent()
        return CGRect(x: xMargin, y: yMargin, width: x, height: y)
    }
    
    func getPersentByRectHeight(persent: Double) -> Double{
        return self.height * persent.toPersent()
    }
}
