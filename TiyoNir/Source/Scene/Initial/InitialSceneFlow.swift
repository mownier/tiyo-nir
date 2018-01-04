//
//  InitialSceneFlow.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/2/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit
import TNCore

protocol InitialSceneFlow: class {
    
    func showTextsScene() -> Bool
}

extension InitialScene {
    
    class Flow: InitialSceneFlow, SceneInjectable {
        
        struct Factory {
            
            var nav: NavigationControllerFactory {
                let factory = UINavigationController.Factory()
                return factory
            }
            
            func textsScene(withWaypoint waypoint: ExitWaypoint) -> TextsSceneFactory {
                let factory = TextsScene.Factory(waypoint: waypoint)
                return factory
            }
        }
        
        struct Delegate {
            
            var textsScene: TextsSceneDelegate
        }
        
        struct Theme {
            
            var nav: NavigationControllerTheme
            var textsScene: TextsSceneTheme
        }
        
        weak var scene: UIViewController?
        
        var theme: Theme
        var factory: Factory
        var waypoint: PresentWaypoint & ExitWaypoint
        var delegate: Delegate
        
        init() {
            let themeProvider = AppSceneThemeProvider()
            
            let waypoint = PresentWaypointSource()
            let navTheme = themeProvider.theme.nav
            let textsSceneTheme = themeProvider.theme.texts
            let textsSceneDelegate = InitialScene.Delegate.TextsScene()
            
            let theme = Theme(nav: navTheme, textsScene: textsSceneTheme)
            let factory = Factory()
            let delegate = Delegate(textsScene: textsSceneDelegate)
            
            self.theme = theme
            self.factory = factory
            self.waypoint = waypoint
            self.delegate = delegate
        }
        
        func showTextsScene() -> Bool {
            guard let scene = scene else {
                return false
            }
            
            let textsScene = factory.textsScene(withWaypoint: waypoint).withTheme(theme.textsScene).withDelegate(delegate.textsScene).build()
            let nav = factory.nav.withTheme(theme.nav).withRoot(textsScene).build()
            return waypoint.withScene(nav).enter(from: scene)
        }
        
        func injectScene(_ aScene: UIViewController) {
            scene = aScene
        }
    }
}
