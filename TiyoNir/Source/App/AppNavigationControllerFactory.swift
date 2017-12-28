
import UIKit

public protocol AppNavigationControllerFactory: class {
    
    func build(withRoot root: UIViewController) -> UINavigationController
}

public protocol AppNavigationControllerTheme: class {
    
    var shadowImage: UIImage? { get }
    var bgImage: UIImage? { get }
    
    var isTranslucent: Bool { get }
    
    var tintColor: UIColor? { get }
    
    var barTintColor: UIColor? { get }
    var barTitleFont: UIFont? { get }
    var barTitleTextColor: UIColor? { get }
}

public extension UINavigationController {
    
    public class Theme: AppNavigationControllerTheme {
        
        public var shadowImage: UIImage?
        public var bgImage: UIImage?
        
        public var isTranslucent: Bool = false
        
        public var tintColor: UIColor?
        
        public var barTintColor: UIColor?
        public var barTitleFont: UIFont?
        public var barTitleTextColor: UIColor?
    }
    
    public class Factory: AppNavigationControllerFactory {
        
        let theme: AppNavigationControllerTheme
        
        public init(theme: AppNavigationControllerTheme) {
            self.theme = theme
        }
        
        public convenience init() {
            let theme = Theme()
            self.init(theme: theme)
        }
        
        public func build(withRoot root: UIViewController) -> UINavigationController {
            let nav = UINavigationController(rootViewController: root)
            nav.navigationBar.isTranslucent = theme.isTranslucent
            
            if theme.shadowImage != nil {
                nav.navigationBar.shadowImage = theme.shadowImage
            }
            
            if theme.bgImage != nil {
                nav.navigationBar.setBackgroundImage(theme.bgImage, for: .default)
            }
            
            if theme.barTintColor != nil {
                nav.navigationBar.barTintColor = theme.barTintColor
            }
            
            if theme.tintColor != nil {
                nav.navigationBar.tintColor = theme.tintColor
            }
            
            var textAttribs: [NSAttributedStringKey: Any] = [:]
            
            if theme.barTitleFont != nil {
                textAttribs[NSAttributedStringKey.font] = theme.barTitleFont
            }
            
            if theme.barTitleTextColor != nil {
                textAttribs[NSAttributedStringKey.foregroundColor] = theme.barTitleTextColor
            }
            
            if !textAttribs.isEmpty {
                nav.navigationBar.titleTextAttributes = textAttribs
            }
            
            return nav
        }
    }
}
