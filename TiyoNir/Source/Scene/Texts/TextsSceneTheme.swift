//
//  TextsSceneTheme.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import UIKit

public protocol TextsSceneTheme: class {
 
    var bgColor: UIColor { get }
    var backImage: UIImage? { get }
}

public extension TextsScene {
    
    public class Theme: TextsSceneTheme {
        
        public var bgColor: UIColor
        public var backImage: UIImage?
        
        public init() {
            self.bgColor = .white
            self.backImage = #imageLiteral(resourceName: "button_back")
        }
    }
}

protocol TextsSceneThemeInjectable: class {
    
    func injectTheme(_ theme: TextsSceneTheme)
}

class TextsSceneThemeInjector {
    
    func injectTheme(_ theme: TextsSceneTheme, using injectable: TextsSceneThemeInjectable) {
        injectable.injectTheme(theme)
    }
}
