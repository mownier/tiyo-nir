//
//  TextsSceneSetup.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import UIKit

protocol TextsSceneSetup: class {
    
    func formatCell(_ cell: UITableViewCell, item: SceneItem?, action: TextsSceneTableCellAction?) -> Bool
    func computeHeight(for cell: UITableViewCell?, item: SceneItem?) -> CGFloat
    func reuseID(in section: Int, at row: Int) -> String
}

extension TextsScene {
    
    class Setup: TextsSceneSetup, TextsSceneThemeInjectable {
        
        var theme: TextsSceneTheme
        
        init(theme: TextsSceneTheme) {
            self.theme = theme
        }
        
        func formatCell(_ cell: UITableViewCell, item: SceneItem?, action: TextsSceneTableCellAction?) -> Bool {
            guard let cell = cell as? TextsScene.TableCell, let item = item else {
                return false
            }
            
            cell.action = action
            cell.textLabel?.text = item.text.content
            return true
        }
        
        func computeHeight(for cell: UITableViewCell?, item: SceneItem?) -> CGFloat {
            guard let cell = cell as? TextsScene.TableCell, formatCell(cell, item: item, action: nil) else {
                return 0
            }
            
            return 44
        }
        
        func reuseID(in section: Int, at row: Int) -> String {
            return "SceneTableCell"
        }
        
        func injectTheme(_ aTheme: TextsSceneTheme) {
            theme = aTheme
        }
    }
}
