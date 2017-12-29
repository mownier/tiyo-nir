//
//  AppSceneInjector.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/29/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import UIKit

public protocol AppSceneInjectable: class {

    func injectScene(_ scene: UIViewController)
}

public class SceneInjector {
    
    func injectScene(_ scene: UIViewController, using injector: AppSceneInjectable) {
        injector.injectScene(scene)
    }
}
