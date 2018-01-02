//
//  InitialSceneFlow.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/2/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit

public protocol InitialSceneFlow {
    
    func showTextsScene(withDelegate delegate: TextsSceneDelegate?) -> Bool
}

public extension InitialScene {
    
    public class Flow: InitialSceneFlow, AppSceneInjectable {
        
        weak var scene: UIViewController?
        
        public func showTextsScene(withDelegate delegate: TextsSceneDelegate?) -> Bool {
            guard let scene = scene else {
                return false
            }
            
            let waypoint = PresentWaypoint()
            let delegate = Delegate.TextsScene()
            let factory = TextsScene.Factory(waypoint: waypoint)
            let textsScene = factory.withDelegate(delegate).build()
            let nav = UINavigationController.Factory().build(withRoot: textsScene)
            return waypoint.withScene(nav).enter(from: scene)
        }
        
        public func injectScene(_ aScene: UIViewController) {
            scene = aScene
        }
    }
}
