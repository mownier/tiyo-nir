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
        
        weak var scene: UIViewController?
        
        func showTextsScene() -> Bool {
            guard let scene = scene else {
                return false
            }
            
            let delegate = Delegate.TextsScene()
            let waypoint = PresentWaypoint()
            let factory = TextsScene.Factory(waypoint: waypoint)
            let textsScene = factory.withDelegate(delegate).build()
            let nav = UINavigationController.Factory().build(withRoot: textsScene)
            return waypoint.withScene(nav).enter(from: scene)
        }
        
        func injectScene(_ aScene: UIViewController) {
            scene = aScene
        }
    }
}
