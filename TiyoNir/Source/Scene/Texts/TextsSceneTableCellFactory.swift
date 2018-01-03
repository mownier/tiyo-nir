
import UIKit

extension TextsScene {
    
    class TableCellLaborer: AppTableCellFactoryLaborer, TextsSceneThemeInjectable {
        
        var theme: TextsSceneTheme
        
        var prototype: UITableViewCell?
        
        init(theme: TextsSceneTheme, isHeightDynamic: Bool) {
            self.theme = theme
            
            guard isHeightDynamic else {
                return
            }
            
            self.prototype = TableCell(style: .default, reuseIdentifier: "prototype")
        }
        
        func build(using tableView: UITableView, with reuseID: String) -> UITableViewCell {
            var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: reuseID)
            if cell == nil {
                let aCell =  TableCell(style: .default, reuseIdentifier: reuseID)
                cell = aCell
            }
            return cell
        }
        
        func injectTheme(_ aTheme: TextsSceneTheme) {
            theme = aTheme
        }
    }
    
    class TableCellFactory: AppTableCellFactory {
        
        let laborer: AppTableCellFactoryLaborer
        
        init(laborer: AppTableCellFactoryLaborer) {
            self.laborer = laborer
        }
        
        func prototype(in section: Int, at row: Int) -> UITableViewCell? {
            return laborer.prototype
        }
        
        func build(using tableView: UITableView, with reuseID: String, in section: Int, at row: Int) -> UITableViewCell {
            return laborer.build(using: tableView, with: reuseID)
        }
    }
}
