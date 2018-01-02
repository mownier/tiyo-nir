//
//  AppDelegate.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var waypoint: AppRootWaypoint!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        window?.makeKeyAndVisible()
        
        let waypoint = Waypoint(window: window)
        let _ = waypoint.makeRoot()
        
        return true
    }
}
