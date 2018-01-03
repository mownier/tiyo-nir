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
    var statusBarStyle: UIStatusBarStyle { get }
}

public extension InitialScene {
    
    public class Theme: InitialSceneTheme {
        
        public var bgColor: UIColor
        public var statusBarStyle: UIStatusBarStyle
        
        public init() {
            self.bgColor = .white
            self.statusBarStyle = .default
        }
    }
}
