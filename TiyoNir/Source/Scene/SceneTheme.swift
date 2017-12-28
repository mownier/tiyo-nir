
import UIKit

public protocol SceneTheme: class {
 
    var bgColor: UIColor { get }
}

public extension Scene {
    
    public class Theme: SceneTheme {
        
        public var bgColor: UIColor = .white
    }
}
