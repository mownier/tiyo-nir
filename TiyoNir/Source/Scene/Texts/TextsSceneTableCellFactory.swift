
import UIKit

public extension TextsScene {
    
    public class TableCellLaborer: AppTableCellFactoryLaborer, TextsSceneThemeInjectable {
        
        var theme: TextsSceneTheme
        
        public var prototype: UITableViewCell?
        
        public init(theme: TextsSceneTheme, isHeightDynamic: Bool) {
            self.theme = theme
            
            guard isHeightDynamic else {
                return
            }
            
            self.prototype = TableCell(style: .default, reuseIdentifier: "prototype")
        }
        
        public func build(using tableView: UITableView, with reuseID: String) -> UITableViewCell {
            var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: reuseID)
            if cell == nil {
                let aCell =  TableCell(style: .default, reuseIdentifier: reuseID)
                cell = aCell
            }
            return cell
        }
        
        public func injectTheme(_ aTheme: TextsSceneTheme) {
            theme = aTheme
        }
    }
    
    public class TableCellFactory: AppTableCellFactory {
        
        let laborer: AppTableCellFactoryLaborer
        
        public init(laborer: AppTableCellFactoryLaborer) {
            self.laborer = laborer
        }
        
        public func prototype(in section: Int, at row: Int) -> UITableViewCell? {
            return laborer.prototype
        }
        
        public func build(using tableView: UITableView, with reuseID: String, in section: Int, at row: Int) -> UITableViewCell {
            return laborer.build(using: tableView, with: reuseID)
        }
    }
}
