//
//  TextsSceneDelegate.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/29/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import UIKit

public protocol TextsSceneDelegate: class {
    
    func sceneDidFetchTexts(_ texts: [Text])
    func sceneDidFetchWithError(_ error: Error)
}

public protocol SceneDelegateInjectable: class {
    
    func injectDelegate(_ delegate: TextsSceneDelegate?)
}

public class SceneDelegateInjector {
    
    func injectDelegate(_ delegate: TextsSceneDelegate?, using injectable: SceneDelegateInjectable) {
        injectable.injectDelegate(delegate)
    }
}
