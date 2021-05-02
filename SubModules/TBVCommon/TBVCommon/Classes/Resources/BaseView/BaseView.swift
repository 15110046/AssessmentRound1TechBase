
import UIKit

open class BaseView: UIControl {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    func getNibName() -> String {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }
    
    func load() {
        let bundle = Bundle.init(for: Self.self)
        let nib = UINib(nibName: getNibName(), bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
        if let childView = views.first as? UIView {
            addViewOverlay(childView: childView, toView: self)
            loadingViewComplete(childView: childView)
        }
    }
    
    func loadingViewComplete(childView: UIView) {
        
    }
    
    func addViewOverlay(childView: UIView, toView parentView: UIView) {
        parentView.addSubview(childView)
        if frame == CGRect.zero {
            frame = childView.frame
        } else {
            childView.frame = bounds
        }
        BaseView.addConstrainOverlay(childView: childView, toView: parentView)
    }
    
    static func addConstrainOverlay(childView: UIView, toView parentView: UIView) {
        
        childView.bounds = parentView.bounds
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXConstraint = NSLayoutConstraint(item: childView,
                                                   attribute: NSLayoutConstraint.Attribute.centerX,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   toItem: parentView,
                                                   attribute: NSLayoutConstraint.Attribute.centerX,
                                                   multiplier: 1, constant: 0)
        
        let centerYConstraint = NSLayoutConstraint(item: childView,
                                                   attribute: NSLayoutConstraint.Attribute.centerY,
                                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                                   toItem: parentView,
                                                   attribute: NSLayoutConstraint.Attribute.centerY,
                                                   multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: childView,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: parentView,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: childView,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: parentView,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 multiplier: 1, constant: 0)
        
        parentView.addConstraints([centerXConstraint, centerYConstraint, heightConstraint, widthConstraint])
    }
}
