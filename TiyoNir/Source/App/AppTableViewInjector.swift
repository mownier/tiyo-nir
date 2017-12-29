//
//  AppTableViewInjector.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/29/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import UIKit

public protocol AppTableViewInjectable: class {
    
    func injectTableView(_ tableView: UITableView)
}

public class TableViewInjector {

    func injectTableView(_ tableView: UITableView, using injectable: AppTableViewInjectable) {
        injectable.injectTableView(tableView)
    }
}
