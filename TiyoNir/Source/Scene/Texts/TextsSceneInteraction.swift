
import Foundation

@objc public protocol TextsSceneInteraction: class {
    
    func didTapBack()
}

public extension TextsScene {
    
    public class Interaction: TextsSceneInteraction {
        
        var waypoint: AppExitWaypoint
        
        public init(waypoint: AppExitWaypoint) {
            self.waypoint = waypoint
        }
        
        public func didTapBack() {
            let _ = waypoint.exit()
        }
    }
}
