//
//  InitialSceneFactory.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/2/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit

public protocol InitialSceneFactory: class {
    
    func withTheme(_ theme: InitialSceneTheme) -> AppSceneFactory
}

public extension InitialScene {
    
    public class Factory: AppSceneFactory, InitialSceneFactory {
        
        class Injector {
            
            var scene: SceneInjector
            
            init() {
                self.scene = SceneInjector()
            }
        }
        
        class Injectable {
            
            var scenes: [AppSceneInjectable]
            
            init() {
                self.scenes = []
            }
        }
        
        var flow: InitialSceneFlow!
        var theme: InitialSceneTheme!
        
        var injector: Injector
        var injectable: Injectable
        
        public init() {
            let flow = Flow()
            let theme = Theme()
            
            self.flow = flow
            self.theme = theme
            
            self.injector = Injector()
            self.injectable = Injectable()
            
            self.injectable.scenes.append(flow)
        }
        
        public func build() -> UIViewController {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let scene = sb.instantiateViewController(withIdentifier: "InitialScene") as! InitialScene
            
            scene.flow = flow
            scene.theme = theme
            
            for injectable in injectable.scenes {
                injector.scene.injectScene(scene, using: injectable)
            }
            
            return scene
        }
        
        public func withTheme(_ aTheme: InitialSceneTheme) -> AppSceneFactory {
            theme = aTheme
            return self
        }
    }
}
