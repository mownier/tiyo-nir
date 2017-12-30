
import UIKit

public protocol AppEntryWaypoint: class {
    
    func enter(from parent: UIViewController) -> Bool
}

public protocol AppExitWaypoint: class {
    
    func exit() -> Bool
}

public protocol AppRootWaypoint: class {
    
    func makeRoot(in window: UIWindow?) -> Bool
}
