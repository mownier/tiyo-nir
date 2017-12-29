//
//  SceneDelegate.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/29/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import UIKit

public protocol SceneDelegate: class {
    
    func sceneWillGoBack()
    func sceneDidFetchTexts(_ texts: [Text])
}

public protocol SceneDelegateInjectable: class {
    
    func injectDelegate(_ delegate: SceneDelegate?)
}

public class SceneDelegateInjector {
    
    func injectDelegate(_ delegate: SceneDelegate?, using injectable: SceneDelegateInjectable) {
        injectable.injectDelegate(delegate)
    }
}