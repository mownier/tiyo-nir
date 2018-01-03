//
//  AppSceneTheme.wift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/3/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit
import TNCore

public protocol AppSceneTheme {
    
    var initial: InitialSceneTheme { get }
    var texts: TextsSceneTheme { get }
    var nav: NavigationControllerTheme { get }
}

public enum AppSceneThemeStyle {
    
    case `default`
    case dark
}

public class AppSceneThemeProvider {
    
    public let theme: AppSceneTheme
    
    public init(style: AppSceneThemeStyle) {
        switch style {
        case .default:
            self.theme = AppSceneThemeDefault()
        
        case .dark:
            self.theme = AppSceneThemeDark()
        }
    }
    
    public convenience init(userDefaults: UserDefaults = UserDefaults.standard) {
        let theme = userDefaults.integer(forKey: "theme")
        let style: AppSceneThemeStyle
        switch theme {
        case 1: style = .default
        default: style = .dark
        }
        self.init(style: style)
    }
}
