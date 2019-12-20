import UIKit
class CircleImageView: UIImageView {
    var horizontalConstraint: NSLayoutConstraint?
    var verticalConstraint: NSLayoutConstraint?
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.size.width / 2.0
    }
}
