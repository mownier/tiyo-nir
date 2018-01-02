
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
        
        
        public struct Defaults {
            
            public var theme: SceneTheme
        }
        
        var factory: Factory
        var defaults: Defaults
        
        var theme: SceneTheme?
        var delegate: SceneDelegate?
        
        public init(factory: Factory, defaults: Defaults) {
            self.factory = factory
            self.defaults = defaults
        }
        
        public convenience init(factory: Factory) {
            let defaults = Defaults(theme: Theme())
            self.init(factory: factory, defaults: defaults)
        }
        
        public convenience init() {
            let scene = Scene.Factory()
            let defaults = Defaults(theme: Theme())
            let factory = Factory(scene: scene)
            self.init(factory: factory, defaults: defaults)
        }
        
        public class Entry: Waypoint, AppEntryWaypoint, SceneEntryWaypoint {
            
            public func enter(from parent: UIViewController) -> Bool {
                let sceneTheme: SceneTheme = theme == nil ? defaults.theme : theme!
                let scene = factory.scene.withTheme(sceneTheme).withDelegate(delegate).build()
                parent.present(scene, animated: true, completion: nil)
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
            
            public func makeRoot(in window: UIWindow?) -> Bool {
                guard let window = window, window.isKeyWindow else {
                    return false
                }
                
                let sceneTheme: SceneTheme = theme == nil ? defaults.theme : theme!
                let scene = factory.scene.withTheme(sceneTheme).withDelegate(delegate).build()
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
        }
    }
}

