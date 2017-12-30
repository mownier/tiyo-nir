
import UIKit

public protocol SceneEntryWaypoint: class {
    
    func withTheme(_ theme: SceneTheme) -> AppEntryWaypoint & SceneEntryWaypoint
    func withDelegate(_ delegate: SceneDelegate?) -> AppEntryWaypoint & SceneEntryWaypoint
}

public protocol SceneRootWaypoint: class {
    
    func withTheme(_ theme: SceneTheme) -> AppRootWaypoint & SceneRootWaypoint
    func withDelegate(_ delegate: SceneDelegate?) -> AppRootWaypoint & SceneRootWaypoint
}

public extension Scene {
    
    public class Waypoint {
    
        public struct Factory {
            
            public var scene: SceneFactory
        }
        
        let factory: Factory
        
        public init(factory: Factory) {
            self.factory = factory
        }
        
        public convenience init() {
            let scene = Scene.Factory()
            let factory = Factory(scene: scene)
            self.init(factory: factory)
        }
        
        public class Entry: Waypoint, AppEntryWaypoint, SceneEntryWaypoint {
            
            var theme: SceneTheme! = Theme()
            var delegate: SceneDelegate?
            
            public func enter(from parent: UIViewController) -> Bool {
                let scene = factory.scene.withTheme(theme).withDelegate(delegate).build()
                parent.present(scene, animated: true, completion: nil)
                cleanUp()
                return true
            }
            
            public func withTheme(_ aTheme: SceneTheme) -> AppEntryWaypoint & SceneEntryWaypoint {
                theme = aTheme
                return self
            }
            
            public func withDelegate(_ aDelegate: SceneDelegate?) -> AppEntryWaypoint & SceneEntryWaypoint {
                delegate = aDelegate
                return self
            }
            
            func cleanUp() {
                delegate = nil
                theme = nil
            }
        }
        
        public class Exit: AppExitWaypoint, AppSceneInjectable {
            
            weak var scene: UIViewController?
            
            public func exit() -> Bool {
                guard let scene = scene else {
                    return false
                }
                
                scene.dismiss(animated: true, completion: nil)
                return true
            }
            
            public func injectScene(_ aScene: UIViewController) {
                scene = aScene
            }
        }
        
        public class Root: Waypoint, AppRootWaypoint, SceneRootWaypoint {
            
            var theme: SceneTheme! = Theme()
            var delegate: SceneDelegate?
            
            public func makeRoot(from window: UIWindow?) -> Bool {
                guard let window = window, window.isKeyWindow else {
                    return false
                }
                
                let scene = factory.scene.withDelegate(nil).build()
                window.rootViewController = scene
                return true
            }
            
            public func withTheme(_ aTheme: SceneTheme) -> AppRootWaypoint & SceneRootWaypoint {
                theme = aTheme
                return self
            }
            
            public func withDelegate(_ aDelegate: SceneDelegate?) -> AppRootWaypoint & SceneRootWaypoint {
                delegate = aDelegate
                return self
            }
            
            func cleanUp() {
                delegate = nil
                theme = nil
            }
        }
    }
}

