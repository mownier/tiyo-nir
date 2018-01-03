//
//  AppSceneThemeBuilder.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/3/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit

public enum AppSceneThemeBuilder {
    
    public class Initial: InitialSceneThemeBuilder {
        
        public func build() -> InitialSceneTheme {
            return InitialScene.Theme()
        }
    }
    
    public class Texts: TextsSceneThemeBuilder {
        
        public func build() -> TextsSceneTheme {
            return TextsScene.Theme()
        }
    }
}

