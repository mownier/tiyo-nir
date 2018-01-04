//
//  TextsSceneInteraction.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

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
