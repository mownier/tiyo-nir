//
//  AppSceneThemeDefault.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/3/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit
import TNCore

public class AppSceneThemeDefault: AppSceneTheme {
    
    public var initial: InitialSceneTheme
    public var texts: TextsSceneTheme
    public var nav: NavigationControllerTheme
    
    public init() {
        self.initial = InitialScene.Theme()
        self.texts = TextsScene.Theme()
        self.nav = UINavigationController.Theme()
    }
}
