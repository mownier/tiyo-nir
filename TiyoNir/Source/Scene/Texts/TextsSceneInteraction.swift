
import Foundation
import TNCore

@objc protocol TextsSceneInteraction: class {
    
    func didTapBack()
}

extension TextsScene {
    
    class Interaction: TextsSceneInteraction {
        
        var waypoint: ExitWaypoint
        
        init(waypoint: ExitWaypoint) {
            self.waypoint = waypoint
        }
        
        func didTapBack() {
            let _ = waypoint.exit()
        }
    }
}
