
import UIKit

public protocol TextsSceneTheme: class {
 
    var bgColor: UIColor { get }
    var backImage: UIImage? { get }
}

public protocol TextsSceneThemeBuilder: class {
    
    func build() -> TextsSceneTheme
}

public extension TextsScene {
    
    public class Theme: TextsSceneTheme {
        
        public var bgColor: UIColor
        public var backImage: UIImage?
        
        public init() {
            self.bgColor = .white
            self.backImage = #imageLiteral(resourceName: "button_back")
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
