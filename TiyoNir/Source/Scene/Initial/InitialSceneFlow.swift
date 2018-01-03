//
//  InitialSceneFlow.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/2/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit

protocol InitialSceneFlow: class {
    
    func showTextsScene() -> Bool
}

extension InitialScene {
    
    class Flow: InitialSceneFlow, AppSceneInjectable {
        
        struct Factory {
            
            var nav: AppNavigationControllerFactory
            var textsScene: TextsSceneFactory
        }
        
        struct Delegate {
            
            var textsScene: TextsSceneDelegate
        }
        
        struct Theme {
            
            var nav: AppNavigationControllerTheme
            var textsScene: TextsSceneTheme
        }
        
        weak var scene: UIViewController?
        
        var theme: Theme
        var factory: Factory
        var waypoint: AppPresentWaypoint
        var delegate: Delegate
        
        init() {
            let themeProvider = AppSceneThemeProvider()
            
            let waypoint = PresentWaypoint()
            let navTheme = themeProvider.theme.nav
            let navFactory = UINavigationController.Factory()
            let textsSceneTheme = themeProvider.theme.texts
            let textsSceneFactory = TextsScene.Factory(waypoint: waypoint)
            let textsSceneDelegate = InitialScene.Delegate.TextsScene()
            
            let theme = Theme(nav: navTheme, textsScene: textsSceneTheme)
            let factory = Factory(nav: navFactory, textsScene: textsSceneFactory)
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
            
            let textsScene = factory.textsScene.withTheme(theme.textsScene).withDelegate(delegate.textsScene).build()
            let nav = factory.nav.withTheme(theme.nav).withRoot(textsScene).build()
            return waypoint.withScene(nav).enter(from: scene)
        }
        
        func injectScene(_ aScene: UIViewController) {
            scene = aScene
        }
    }
}
