
import UIKit

public protocol AppNavigationControllerFactory: class {
    
    func withTheme(_ theme: AppNavigationControllerTheme) -> AppNavigationControllerFactory
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
    
    var barStyle: UIBarStyle { get }
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
        
        public var barStyle: UIBarStyle = .default
    }
    
    public class Factory: AppNavigationControllerFactory {
        
        var theme: AppNavigationControllerTheme
        
        public init() {
            self.theme = Theme()
        }
        
        public func withTheme(_ aTheme: AppNavigationControllerTheme) -> AppNavigationControllerFactory {
            theme = aTheme
            return self
        }
        
        public func build(withRoot root: UIViewController) -> UINavigationController {
            let nav = UINavigationController(rootViewController: root)
            nav.navigationBar.isTranslucent = theme.isTranslucent
            nav.navigationBar.barStyle = theme.barStyle
            
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
