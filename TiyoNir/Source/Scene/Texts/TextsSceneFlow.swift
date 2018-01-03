
import UIKit

protocol TextsSceneFlow: class {
    
    func showErrorScene(withError error: Error) -> Bool
}

extension TextsScene {
    
    class Flow: TextsSceneFlow, AppSceneInjectable {
        
        weak var scene: UIViewController?
        
        public func showErrorScene(withError error: Error) -> Bool {
            return true
        }
        
        public func injectScene(_ aScene: UIViewController) {
            scene = aScene
        }
    }
}

