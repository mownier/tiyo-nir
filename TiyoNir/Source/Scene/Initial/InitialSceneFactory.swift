//
//  InitialSceneFactory.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/2/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit

public protocol InitialSceneFactory {
    
    func withDelegate(_ delegate: InitialSceneDelegate?) -> AppSceneFactory
}

public extension InitialScene {
    
    public class Factory: AppSceneFactory, InitialSceneFactory, InitialSceneDelegateInjectable {
        
        weak var delegate: InitialSceneDelegate?
        
        public func build() -> UIViewController {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let scene = sb.instantiateViewController(withIdentifier: "InitialScene") as! InitialScene
            return scene
        }
        
        public func withDelegate(_ aDelegate: InitialSceneDelegate?) -> AppSceneFactory {
            delegate = aDelegate
            return self
        }
        
        public func injectDelegate(_ aDelegate: InitialSceneDelegate?) {
            delegate = aDelegate
        }
    }
}
