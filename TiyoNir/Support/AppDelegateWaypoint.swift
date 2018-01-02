//
//  AppDelegateWaypoint.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/3/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    class Waypoint: AppRootWaypoint {
        
        var window: UIWindow?
        
        init(window: UIWindow?) {
            self.window = window
        }
        
        func makeRoot() -> Bool {
            let scene = InitialScene.Factory().build()
            let nav = UINavigationController.Factory().build(withRoot: scene)
            let waypoint = WindowWaypoint()
            
            return waypoint.withWindow(window).withScene(nav).makeRoot()
        }
    }
}
