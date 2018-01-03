
import Foundation

@objc protocol TextsSceneInteraction: class {
    
    func didTapBack()
}

extension TextsScene {
    
    class Interaction: TextsSceneInteraction {
        
        var waypoint: AppExitWaypoint
        
        init(waypoint: AppExitWaypoint) {
            self.waypoint = waypoint
        }
        
        func didTapBack() {
            let _ = waypoint.exit()
        }
    }
}
