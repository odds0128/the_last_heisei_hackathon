import UIKit

// MARK: - Extensions for UIView

extension UIViewController {
    func canPerformSegue(with identifier: String) -> Bool {
        let segues = self.value(forKey: "storyboardSegueTemplates") as? [NSObject] ?? []
        for segue in segues{
            if (segue.value(forKey: "identifier") as? String) == identifier{
                return true
            }
        }
        
        return false
    }
}

private let _UIAlertActionImageKey = "_image"
private let _UIAlertActionTitleTextAlignmentRawValueKey = "_titleTextAlignment"
private let _UIAlertActionDescriptiveTextKey = "__descriptiveText"

extension UIAlertAction{
    convenience init(title:String?, style:UIAlertAction.Style, image:UIImage? = nil, descriptiveText:String? = nil, handler:((UIAlertAction)->Void)?) {
        self.init(title: title, style: style, handler: handler)
        self.image = image
        self.descriptiveText = descriptiveText
    }
    convenience init(title:String?, style:UIAlertAction.Style, image:UIImage? = nil, titleTextAlignment:NSTextAlignment? = nil, handler:((UIAlertAction)->Void)?) {
        self.init(title: title, style: style, handler: handler)
        self.image = image
        self.titleTextAlignment = titleTextAlignment
    }
    
    var image:UIImage? {
        get{
            guard self.hasProperty(for: _UIAlertActionImageKey) else { return nil }
            
            return self.value(forKey: _UIAlertActionImageKey) as? UIImage
        }
        set{
            self.setValue(newValue, forKey: _UIAlertActionImageKey)
        }
    }
    var titleTextAlignment:NSTextAlignment?{
        get{
            guard self.hasProperty(for: _UIAlertActionTitleTextAlignmentRawValueKey) else {
                return nil
            }
            
            let rawValue = self.value(forKey: _UIAlertActionTitleTextAlignmentRawValueKey) as! Int
            return NSTextAlignment(rawValue: rawValue)
        }
        set{
            self.setValue(newValue?.rawValue, forKey: _UIAlertActionTitleTextAlignmentRawValueKey)
        }
    }
    var descriptiveText:String?{
        get{
            guard self.hasProperty(for: _UIAlertActionDescriptiveTextKey) else {
                return nil
            }
            
            return self.value(forKey: _UIAlertActionDescriptiveTextKey) as? String
        }
        set{
            self.setValue(newValue, forKey: _UIAlertActionDescriptiveTextKey)
        }
    }
}

// MARK: - Extensions for UITableView
extension UITableView{
    
    /// Scrolls the table view to the top.
    /// The display will collapse with the scrolling view method.
    ///
    /// - Parameter animated: Flag Animated.
    func scrollToTop(animated: Bool){
        self.scrollToRow(at: [0,0], at: .top, animated: animated)
    }
}

extension UITextView{
    func scrollToBottom() {
        if self.text.count > 0 {
            let location = self.text.count - 1
            let bottom = NSMakeRange(location, 1)
            self.scrollRangeToVisible(bottom)
        }
    }
}
