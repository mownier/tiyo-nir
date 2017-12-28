
import UIKit

public protocol SceneFactory: class {
    
    func withDelegate(_ aDelegate: SceneDelegate?) -> AppSceneFactory
}

public extension Scene {
    
    public class Factory: SceneFactory, AppSceneFactory {
        
        weak var delegate: SceneDelegate?
        
        public func build() -> UIViewController {
            let scene = Scene()
            scene.delegate = delegate
            delegate = nil
            return scene
        }

        public func withDelegate(_ aDelegate: SceneDelegate?) -> AppSceneFactory {
            delegate = aDelegate
            return self
        }
    }
}

