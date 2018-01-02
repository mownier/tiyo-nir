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
        let delegate = ViewControllerSceneDelegate()
        let factory = TextsScene.Factory(waypoint: waypoint)
        let scene = factory.withDelegate(delegate).build()
        let nav = UINavigationController.Factory().build(withRoot: scene)
        let _ = waypoint.withScene(nav).enter(from: self)
    }
}

class ViewControllerSceneDelegate: SceneDelegate {
    
    func sceneDidFetchTexts(_ texts: [Text]) {
        print(texts)
    }
    
    func sceneDidFetchWithError(_ error: Error) {
        print(error)
    }
}
