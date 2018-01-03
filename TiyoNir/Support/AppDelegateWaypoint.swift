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
            
            var nav: AppNavigationControllerFactory
            var initialScene: InitialSceneFactory
        }
        
        struct Theme {
            
            var initialScene: InitialSceneTheme
        }
        
        var window: UIWindow?
        var factory: Factory
        var waypoint: AppWindowWaypoint
        var theme: Theme
        
        init(window: UIWindow?) {
            let waypoint = WindowWaypoint()
            let navFactory = UINavigationController.Factory()
            let initialSceneTheme = AppSceneThemeBuilder.Initial().build()
            let initialSceneFactory = InitialScene.Factory()
            
            let theme = Theme(initialScene: initialSceneTheme)
            let factory = Factory(initialScene: initialSceneFactory, nav: navFactory)
            
            self.theme = theme
            self.window = window
            self.factory = factory
            self.waypoint = waypoint
        }
        
        func makeRoot() -> Bool {
            let scene = factory.initialScene.withTheme(theme.initialScene).build()
            let nav = factory.nav.build(withRoot: scene)
            return waypoint.withWindow(window).withScene(nav).makeRoot()
        }
    }
}

