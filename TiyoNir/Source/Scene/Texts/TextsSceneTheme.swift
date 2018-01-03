
import UIKit

public protocol TextsSceneTheme: class {
 
    var bgColor: UIColor { get }
    var backImage: UIImage? { get }
    var statusBarStyle: UIStatusBarStyle { get }
}

public extension TextsScene {
    
    public class Theme: TextsSceneTheme {
        
        public var bgColor: UIColor
        public var backImage: UIImage?
        public var statusBarStyle: UIStatusBarStyle
        
        public init() {
            self.bgColor = .white
            self.backImage = #imageLiteral(resourceName: "button_back")
            self.statusBarStyle = .default
        }
    }
}

protocol TextsSceneThemeInjectable: class {
    
    func injectTheme(_ theme: TextsSceneTheme)
}

class TextsSceneThemeInjector {
    
    func injectTheme(_ theme: TextsSceneTheme, using injectable: TextsSceneThemeInjectable) {
        injectable.injectTheme(theme)
    }
}
