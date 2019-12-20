import UIKit
extension UIImage {
    func cropToBounds(width: CGFloat, height: CGFloat) -> UIImage {
        let cgimage = self.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        let rect: CGRect = CGRect(
            x: posX,
            y: posY,
            width: cgwidth,
            height: cgheight)
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        let image: UIImage = UIImage(
            cgImage: imageRef,
            scale: self.scale,
            orientation: self.imageOrientation)
        return image
    }
}
