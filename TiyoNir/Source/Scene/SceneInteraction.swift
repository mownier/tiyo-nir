
import Foundation

@objc public protocol SceneInteraction: class {
    
    func didTapBack() -> Bool
}

public extension Scene {
    
    public class Interaction: SceneInteraction, SceneDelegateInjectable {
        
        var waypoint: AppExitWaypoint
        weak var delegate: SceneDelegate?
        
        public init(waypoint: AppExitWaypoint) {
            self.waypoint = waypoint
        }
        
        public func didTapBack() -> Bool {
            delegate?.sceneWillGoBack()
            return waypoint.exit()
        }
        
        public func injectDelegate(_ aDelegate: SceneDelegate?) {
            delegate = aDelegate
        }
    }
}
