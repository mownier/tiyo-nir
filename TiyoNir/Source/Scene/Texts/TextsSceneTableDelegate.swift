//
//  TextsSceneTableDelegate.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import UIKit
import TNCore

extension TextsScene {
    
    class TableDelegate: NSObject, UITableViewDelegate {
        
        var cellFactory: TableCellFactory
        
        var data: TextsSceneData
        var setup: TextsSceneSetup
        
        init(data: TextsSceneData, cellFactory: TableCellFactory, setup: TextsSceneSetup) {
            self.data = data
            self.cellFactory = cellFactory
            self.setup = setup
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let section = indexPath.section
            let row = indexPath.row
            let item = data.item(at: row)
            let prototype = cellFactory.prototype(in: section, at: row)
            let height = setup.computeHeight(for: prototype, item: item)
            return height
        }
    }
}
