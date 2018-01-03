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
            
            var textsScene: TextsSceneFactory
            var nav: AppNavigationControllerFactory
        }
        
        struct Delegate {
            
            var textsScene: TextsSceneDelegate
        }
        
        weak var scene: UIViewController?
        
        var waypoint: AppPresentWaypoint
        var factory: Factory
        var delegate: Delegate
        
        init() {
            let waypoint = PresentWaypoint()
            let navFactory = UINavigationController.Factory()
            let textsSceneFactory = TextsScene.Factory(waypoint: waypoint)
            let textsSceneDelegate = InitialScene.Delegate.TextsScene()
            
            let factory = Factory(textsScene: textsSceneFactory, nav: navFactory)
            let delegate = Delegate(textsScene: textsSceneDelegate)
            
            self.waypoint = waypoint
            self.factory = factory
            self.delegate = delegate
        }
        
        func showTextsScene() -> Bool {
            guard let scene = scene else {
                return false
            }
            
            let textsScene = factory.textsScene.withDelegate(delegate.textsScene).build()
            let nav = factory.nav.build(withRoot: textsScene)
            return waypoint.withScene(nav).enter(from: scene)
        }
        
        func injectScene(_ aScene: UIViewController) {
            scene = aScene
        }
    }
}
