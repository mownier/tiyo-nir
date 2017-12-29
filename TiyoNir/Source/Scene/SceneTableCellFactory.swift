
import UIKit

public extension Scene {
    
    public class TableCellLaborer: AppTableCellFactoryLaborer, SceneThemeInjectable {
        
        var theme: SceneTheme
        
        public var prototype: UITableViewCell?
        
        public init(theme: SceneTheme, isHeightDynamic: Bool) {
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
        
        public func injectTheme(_ aTheme: SceneTheme) {
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