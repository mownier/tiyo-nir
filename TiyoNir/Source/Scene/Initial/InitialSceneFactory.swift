//
//  InitialSceneFactory.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/2/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit
import TNCore

public protocol InitialSceneFactory: class {
    
    func withTheme(_ theme: InitialSceneTheme) -> SceneFactory & InitialSceneFactory
}

public extension InitialScene {
    
    public class Factory: SceneFactory, InitialSceneFactory {
        
        class Injector {
            
            var scene: SceneInjector
            
            init() {
                self.scene = SceneInjector()
            }
        }
        
        class Injectable {
            
            var scenes: [SceneInjectable]
            
            init() {
                self.scenes = []
            }
        }
        
        var flow: InitialSceneFlow
        var theme: InitialSceneTheme
        
        var injector: Injector
        var injectable: Injectable
        var storyboard: UIStoryboard
        var storyboardID: String
        
        public init() {
            let flow = Flow()
            let theme = Theme()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let sbID = "InitialScene"
            
            self.flow = flow
            self.theme = theme
            
            self.injector = Injector()
            self.injectable = Injectable()
            
            self.injectable.scenes.append(flow)
            
            self.storyboard = sb
            self.storyboardID = sbID
        }
        
        public func build() -> UIViewController {
            var scene: InitialScene! = storyboard.instantiateViewController(withIdentifier: storyboardID) as? InitialScene
            
            if scene == nil {
                scene = InitialScene()
            }
            
            scene.flow = flow
            scene.theme = theme
            
            for injectable in injectable.scenes {
                injector.scene.injectScene(scene, using: injectable)
            }
            
            return scene
        }
        
        public func withTheme(_ aTheme: InitialSceneTheme) -> SceneFactory & InitialSceneFactory {
            theme = aTheme
            return self
        }
    }
}
