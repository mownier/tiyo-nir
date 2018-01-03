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

protocol TextsSceneDelegateInjectable: class {
    
    func injectDelegate(_ delegate: TextsSceneDelegate?)
}

class TextsSceneDelegateInjector {
    
    func injectDelegate(_ delegate: TextsSceneDelegate?, using injectable: TextsSceneDelegateInjectable) {
        injectable.injectDelegate(delegate)
    }
}
