import UIKit

// MARK: - Extension for UIColor
extension UIColor {
    /// Hex initializer like css.
    /// Css風なUIColorのイニシャライザー。
    ///
    /// Sample:
    /// let lightGray = UIColor(hex: 0xf3f3f3)
    /// let transparentRed = UIColor(hex: 0x670000,alpha: 0.5)
    ///
    /// - Parameters:
    ///   - hex: Hex value of the color (ex 0xf3f3f3 or 0x676767
    ///   - alpha: Alpha value of the color default is 1.0
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
