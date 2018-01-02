//
//  ViewController.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import UIKit

public class InitialScene: UIViewController {
    
    @IBAction func didTapButton() {
        let waypoint = PresentWaypoint()
        let delegate = Delegate.TextsScene()
        let factory = TextsScene.Factory(waypoint: waypoint)
        let scene = factory.withDelegate(delegate).build()
        let nav = UINavigationController.Factory().build(withRoot: scene)
        let _ = waypoint.withScene(nav).enter(from: self)
    }
}
