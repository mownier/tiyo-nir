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
        
        struct Factory {
            
            var initialScene: AppSceneFactory
            var nav: AppNavigationControllerFactory
        }
        
        var window: UIWindow?
        var factory: Factory
        var waypoint: AppWindowWaypoint
        
        init(window: UIWindow?) {
            let waypoint = WindowWaypoint()
            let navFactory = UINavigationController.Factory()
            let initialSceneFactory = InitialScene.Factory()
            let factory = Factory(initialScene: initialSceneFactory, nav: navFactory)
            
            self.window = window
            self.factory = factory
            self.waypoint = waypoint
        }
        
        func makeRoot() -> Bool {
            let scene = factory.initialScene.build()
            let nav = factory.nav.build(withRoot: scene)
            return waypoint.withWindow(window).withScene(nav).makeRoot()
        }
    }
}

