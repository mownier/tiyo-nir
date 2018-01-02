//
//  InitialSceneDelegate.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/2/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit

extension InitialScene {
    
    enum Delegate {
        
        class TextsScene: TextsSceneDelegate {
            
            func sceneDidFetchTexts(_ texts: [Text]) {
                print(texts)
            }
            
            func sceneDidFetchWithError(_ error: Error) {
                print(error)
            }
        }
    }
}
