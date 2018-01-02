
import Foundation

@objc public protocol SceneInteraction: class {
    
    func didTapBack()
}

public extension Scene {
    
    public class Interaction: SceneInteraction {
        
        var waypoint: AppExitWaypoint
        
        public init(waypoint: AppExitWaypoint) {
            self.waypoint = waypoint
        }
        
        public func didTapBack() {
            let _ = waypoint.exit()
        }
    }
}
