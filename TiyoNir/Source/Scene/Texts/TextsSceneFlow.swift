//
//  TextsSceneFlow.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import UIKit
import TNCore

protocol TextsSceneFlow: class {
    
    func showErrorScene(withError error: Swift.Error) -> Bool
}

extension TextsScene {
    
    class Flow: TextsSceneFlow, SceneInjectable {
        
        weak var scene: UIViewController?
        
        public func showErrorScene(withError error: Swift.Error) -> Bool {
            return true
        }
        
        public func injectScene(_ aScene: UIViewController) {
            scene = aScene
        }
    }
}

