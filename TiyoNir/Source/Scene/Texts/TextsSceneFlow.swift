
import UIKit

public protocol SceneFlow: class {
    
    func showErrorScene(withError error: Error) -> Bool
}

public extension TextsScene {
    
    public class Flow: SceneFlow, AppSceneInjectable {
        
        weak var scene: UIViewController?
        
        public func showErrorScene(withError error: Error) -> Bool {
            return true
        }
        
        public func injectScene(_ aScene: UIViewController) {
            scene = aScene
        }
    }
}

