//
//  AppSceneThemeDark.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/3/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit

public class AppSceneThemeDark: AppSceneTheme {
    
    public var initial: InitialSceneTheme
    public var texts: TextsSceneTheme
    public var nav: AppNavigationControllerTheme
    
    public init() {
        let initial = InitialScene.Theme()
        let texts = TextsScene.Theme()
        let nav = UINavigationController.Theme()
        
        nav.barTintColor =  .black
        nav.isTranslucent = false
        nav.tintColor = .white
        nav.barTitleTextColor = .white
        
        initial.statusBarStyle = .lightContent
        texts.statusBarStyle = .lightContent
        
        self.initial = initial
        self.texts = texts
        self.nav = nav
    }
}
