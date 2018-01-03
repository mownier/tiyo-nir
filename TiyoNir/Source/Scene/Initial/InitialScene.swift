//
//  ViewController.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import UIKit

public class InitialScene: UIViewController {
    
    var flow: InitialSceneFlow!
    var theme: InitialSceneTheme!
    
    public override func loadView() {
        super.loadView()
        
        view.backgroundColor = theme.bgColor
    }
    
    @IBAction func didTapButton() {
        let _ = flow.showTextsScene()
    }
}
