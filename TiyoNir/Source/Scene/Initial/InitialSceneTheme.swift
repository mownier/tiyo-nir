//
//  InitialSceneTheme.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 1/2/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit

public protocol InitialSceneTheme: class {
    
    var bgColor: UIColor { get }
}

public protocol InitialSceneThemeBuilder: class {
    
    func build() -> InitialSceneTheme
}

public extension InitialScene {
    
    public class Theme: InitialSceneTheme {
        
        public var bgColor: UIColor
        
        public init() {
            self.bgColor = .white
        }
    }
}
