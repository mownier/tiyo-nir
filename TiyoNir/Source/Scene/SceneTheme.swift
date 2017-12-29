
import UIKit

public protocol SceneTheme: class {
 
    var bgColor: UIColor { get }
}

public extension Scene {
    
    public class Theme: SceneTheme {
        
        public var bgColor: UIColor = .white
    }
}

public protocol SceneThemeInjectable: class {
    
    func injectTheme(_ theme: SceneTheme)
}

public class SceneThemeInjector {
    
    func injectTheme(_ theme: SceneTheme, using injectable: SceneThemeInjectable) {
        injectable.injectTheme(theme)
    }
}
