
import UIKit

public protocol SceneFlow: class {
    
    func showErrorScene(withError error: Error) -> Bool
}

public extension Scene {
    
    public class Flow: SceneFlow {
        
        weak var scene: UIViewController?
        
        public func showErrorScene(withError error: Error) -> Bool {
            return true
        }
    }
}

