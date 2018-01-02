
import UIKit

public protocol AppEntryWaypoint: class {
    
    func enter(from parent: UIViewController) -> Bool
}

public protocol AppExitWaypoint: class {
    
    func exit() -> Bool
}

public protocol AppRootWaypoint: class {
    
    func makeRoot() -> Bool
}

public protocol AppWindowWaypoint: class {
    
    func withWindow(_ window: UIWindow?) -> WindowWaypoint
    func withScene(_ scene: UIViewController) -> AppRootWaypoint
}

public protocol AppPushWaypoint: class {
    
    func withAnimatedEntry(_ animated: Bool) -> AppPushWaypoint
    func withAnimatedExit(_ animated: Bool) -> AppPushWaypoint
    func withScene(_ scene: UIViewController) -> AppEntryWaypoint
}

public protocol AppPresentWaypoint: class {
    
    func withCompletionEntry(_ completion: @escaping () -> Void) -> AppPresentWaypoint
    func withCompletionExit(_ completion: @escaping () -> Void) -> AppPresentWaypoint
    func withAnimatedEntry(_ animated: Bool) -> AppPresentWaypoint
    func withAnimatedExit(_ animated: Bool) -> AppPresentWaypoint
    func withScene(_ scene: UIViewController) -> AppEntryWaypoint
}

public class PushWaypoint: AppPushWaypoint, AppEntryWaypoint, AppExitWaypoint, AppSceneInjectable {
    
    weak var scene: UIViewController?
    var isEntryAnimated: Bool = true
    var isExitAnimated: Bool = true
    
    public func enter(from parent: UIViewController) -> Bool {
        guard let scene = scene, !(scene is UINavigationController),
            let nav = parent.navigationController else {
                return false
        }
        
        nav.pushViewController(scene, animated: isEntryAnimated)
        return true
    }
    
    public func exit() -> Bool {
        guard scene != nil, let nav = scene!.navigationController, nav.topViewController == scene else {
            return false
        }
        
        nav.popViewController(animated: isExitAnimated)
        scene = nil
        return true
    }
    
    public func withAnimatedExit(_ animated: Bool) -> AppPushWaypoint {
        isExitAnimated = animated
        return self
    }
    
    public func withAnimatedEntry(_ animated: Bool) -> AppPushWaypoint {
        isEntryAnimated = animated
        return self
    }
    
    public func withScene(_ aScene: UIViewController) -> AppEntryWaypoint {
        scene = aScene
        return self
    }
    
    public func injectScene(_ aScene: UIViewController) {
        scene = aScene
    }
}

public class PresentWaypoint: AppPresentWaypoint, AppEntryWaypoint, AppExitWaypoint, AppSceneInjectable {
    
    weak var scene: UIViewController?
    var isEntryAnimated: Bool = true
    var isExitAnimated: Bool = true
    var completionEntry: (() -> Void)?
    var completionExit: (() -> Void)?
    
    public func enter(from parent: UIViewController) -> Bool {
        guard let scene = scene else {
            return false
        }
        
        parent.present(scene, animated: isEntryAnimated) { [weak self] in
            self?.completionEntry?()
            self?.completionEntry = nil
        }
        
        return true
    }
    
    public func exit() -> Bool {
        guard let scene = scene else {
            return false
        }
        
        scene.dismiss(animated: isExitAnimated) { [weak self] in
            self?.completionExit?()
            self?.completionExit = nil
            self?.scene = nil
        }
        
        return true
    }
    
    public func withCompletionEntry(_ completion: @escaping () -> Void) -> AppPresentWaypoint {
        completionEntry = completion
        return self
    }
    
    public func withCompletionExit(_ completion: @escaping () -> Void) -> AppPresentWaypoint {
        completionExit = completion
        return self
    }
    
    public func withAnimatedEntry(_ animated: Bool) -> AppPresentWaypoint {
        isEntryAnimated = animated
        return self
    }
    
    public func withAnimatedExit(_ animated: Bool) -> AppPresentWaypoint {
        isExitAnimated = animated
        return self
    }
    
    public func withScene(_ aScene: UIViewController) -> AppEntryWaypoint {
        scene = aScene
        return self
    }
    
    public func injectScene(_ aScene: UIViewController) {
        scene = aScene
    }
}

public class WindowWaypoint: AppWindowWaypoint, AppRootWaypoint {
    
    weak var scene: UIViewController?
    var window: UIWindow!
    
    public func makeRoot() -> Bool {
        guard scene != nil, window != nil, window.isKeyWindow else {
            return false
        }
        
        window.rootViewController = scene
        scene = nil
        window = nil
        return true
    }
    
    public func withWindow(_ aWindow: UIWindow?) -> WindowWaypoint {
        window = aWindow
        return self
    }
    
    public func withScene(_ aScene: UIViewController) -> AppRootWaypoint {
        scene = aScene
        return self
    }
}

