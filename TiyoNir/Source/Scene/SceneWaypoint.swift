
import UIKit

public protocol SceneEntryWaypoint: class {
    
    func withDelegate(_ aDelegate: SceneDelegate?) -> AppEntryWaypoint & SceneEntryWaypoint
}

public extension Scene {
    
    public class Waypoint {
    
        let factory: Factory
        
        public init(factory: Factory) {
            self.factory = factory
        }
        
        public convenience init() {
            let scene = Scene.Factory()
            let nav = UINavigationController.Factory()
            let factory = Factory(scene: scene, nav: nav)
            self.init(factory: factory)
        }
        
        public struct Factory {
            
            public var scene: SceneFactory
            public var nav: AppNavigationControllerFactory
        }
        
        public class Entry: Waypoint, AppEntryWaypoint, SceneEntryWaypoint {
            
            weak var delegate: SceneDelegate?
            
            public func enter(from parent: UIViewController) -> Bool {
                let scene = factory.scene.withDelegate(delegate).build()
                let nav = factory.nav.build(withRoot: scene)
                parent.present(nav, animated: true, completion: nil)
                delegate = nil
                return true
            }
            
            public func withDelegate(_ aDelegate: SceneDelegate?) -> AppEntryWaypoint & SceneEntryWaypoint {
                delegate = aDelegate
                return self
            }
        }
        
        public class Exit: AppExitWaypoint {
            
            weak var scene: UIViewController?
            
            public func exit() -> Bool {
                guard let scene = scene else {
                    return false
                }
                
                scene.dismiss(animated: true, completion: nil)
                return true
            }
        }
        
        public class Root: Waypoint, AppRootWaypoint {
            
            public func makeRoot(from window: UIWindow?) -> Bool {
                guard let window = window, window.isKeyWindow else {
                    return false
                }
                
                let scene = factory.scene.withDelegate(nil).build()
                let nav = factory.nav.build(withRoot: scene)
                window.rootViewController = nav
                return true
            }
        }
    }
}

