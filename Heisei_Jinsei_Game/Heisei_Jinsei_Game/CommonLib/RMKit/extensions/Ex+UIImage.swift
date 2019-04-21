import UIKit

// MARK: - Extension for UIColor
extension UIImage {
    // MARK: - ここからSwiftで書かれたもの
    
    /// UIImage witch is filled with a color of size.
    /// 単一色で塗りつぶした画像を生成
    ///
    /// Sample:
    /// let redImage = UIImage.colorImage(.red, size: CGSize(width: 100, height: 100))
    ///
    /// - Parameters:
    ///   - color: Fill Color
    ///   - size: Image Size
    class func colorImage(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        
        let rect = CGRect(origin: .zero, size: size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// Resize the image. The aspect ratio is not kept.
    /// 画像をリサイズ、アスペクト比は保証せず。
    ///
    /// - Parameter size: Size to resize
    /// - Returns: Resized image
    func resized(to size:CGSize)->UIImage{
        if size.width < 0 || size.height < 0 {fatalError("Resize size must bigger than zero.")}
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /// Resize the image like an aspectfit.
    /// 画像をリサイズ、アスペクト比も保証。Size内に収まるようにリサイズ
    ///
    /// - Parameter size: Max size to resize
    /// - Returns: Resized image
    func resized(toFit size:CGSize)->UIImage{
        let aspect = self.size.width / self.size.height
        if size.width/aspect <= size.height{
            return self.resized(to: CGSize(width: size.width, height: size.width/aspect))
        }else{
            return self.resized(to: CGSize(width: size.height * aspect,height: size.height))
        }
    }
    
    func getPixelColor(at point:CGPoint) -> UIColor {
        let pixelData = self.cgImage!.dataProvider!.data
        let data:UnsafePointer = CFDataGetBytePtr(pixelData)
        
        let pixelInfo:Int = ((Int(self.size.width) * Int(point.y)) + Int(point.x)) * 4
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    func masked(by maskImage:UIImage) -> UIImage{
        let maskRef = maskImage.cgImage!
        let mask = CGImage(
            maskWidth: maskRef.width,
            height: maskRef.height,
            bitsPerComponent: maskRef.bitsPerComponent,
            bitsPerPixel: maskRef.bitsPerPixel,
            bytesPerRow: maskRef.bytesPerRow,
            provider: maskRef.dataProvider!,
            decode: nil,
            shouldInterpolate: false
            )!
        let maskedImageRef = self.cgImage!.masking(mask)!
        let maskedImage = UIImage(cgImage: maskedImageRef)
        
        return maskedImage
    }
}
