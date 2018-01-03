//
//  AppDelegateWaypoint.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/3/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit
import TNCore

extension AppDelegate {
    
    class Waypoint: RootWaypoint {
        
        struct Factory {
            
            var nav: NavigationControllerFactory
            var initialScene: InitialSceneFactory
        }
        
        struct Theme {
            
            var nav: NavigationControllerTheme
            var initialScene: InitialSceneTheme
        }
        
        var window: UIWindow?
        var factory: Factory
        var waypoint: WindowWaypoint
        var theme: Theme
        
        init(window: UIWindow?) {
            let themeProvider = AppSceneThemeProvider()
            
            let waypoint = WindowWaypointSource()
            let navTheme = themeProvider.theme.nav
            let navFactory = UINavigationController.Factory()
            let initialSceneTheme = themeProvider.theme.initial
            let initialSceneFactory = InitialScene.Factory()
            
            let theme = Theme(nav: navTheme, initialScene: initialSceneTheme)
            let factory = Factory(nav: navFactory, initialScene: initialSceneFactory)
            
            self.theme = theme
            self.window = window
            self.factory = factory
            self.waypoint = waypoint
        }
        
        func makeRoot() -> Bool {
            let scene = factory.initialScene.withTheme(theme.initialScene).build()
            let nav = factory.nav.withTheme(theme.nav).withRoot(scene).build()
            return waypoint.withWindow(window).withScene(nav).makeRoot()
        }
    }
}

