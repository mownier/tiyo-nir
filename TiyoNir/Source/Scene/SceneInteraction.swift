
import Foundation

@objc public protocol SceneInteraction: class {
    
    func didTapBack() -> Bool
}

public extension Scene {
    
    public class Interaction: SceneInteraction {
        
        var waypoint: AppExitWaypoint
        
        public init(waypoint: AppExitWaypoint) {
            self.waypoint = waypoint
        }
        
        public func didTapBack() -> Bool {
            return waypoint.exit()
        }
    }
}
