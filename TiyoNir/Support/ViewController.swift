//
//  ViewController.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapButton() {
        let waypoint = PresentWaypoint()
        let factory = Scene.Factory(waypoint: waypoint)
        let scene = factory.withDelegate(self).build()
        let nav = UINavigationController.Factory().build(withRoot: scene)
        let _ = waypoint.withScene(nav).enter(from: self)
    }
}

extension ViewController: SceneDelegate {
    
    func sceneWillGoBack() {
        print("did go back")
    }
    
    func sceneDidFetchTexts(_ texts: [Text]) {
        print(texts)
    }
}

