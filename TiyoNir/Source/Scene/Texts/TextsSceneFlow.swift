
import UIKit

public protocol TextsSceneFlow: class {
    
    func showErrorScene(withError error: Error) -> Bool
}

public extension TextsScene {
    
    public class Flow: TextsSceneFlow, AppSceneInjectable {
        
        weak var scene: UIViewController?
        
        public func showErrorScene(withError error: Error) -> Bool {
            return true
        }
        
        public func injectScene(_ aScene: UIViewController) {
            scene = aScene
        }
    }
}

