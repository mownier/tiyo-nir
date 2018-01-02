//
//  InitialSceneDelegate.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/2/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit

public protocol InitialSceneDelegate: class {

}

public protocol InitialSceneDelegateInjectable: class {
    
    func injectDelegate(_ delegate: InitialSceneDelegate?)
}

public class IntialSceneDelegateInjector {
    
    func injectDelegate(_ delegate: InitialSceneDelegate?, using injectable: InitialSceneDelegateInjectable) {
        injectable.injectDelegate(delegate)
    }
}

public extension InitialScene {
    
    public enum Delegate {
        
        public class TextsScene: TextsSceneDelegate {
            
            public func sceneDidFetchTexts(_ texts: [Text]) {
                print(texts)
            }
            
            public func sceneDidFetchWithError(_ error: Error) {
                print(error)
            }
        }
    }
}
