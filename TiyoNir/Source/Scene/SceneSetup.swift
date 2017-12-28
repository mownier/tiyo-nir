
import UIKit

public protocol SceneSetup: class {
    
    func formatNavigationItem(_ navigationItem: UINavigationItem, title: String?) -> Bool
    func formatCell(_ cell: UITableViewCell, item: SceneItem?, action: SceneTableCellAction?) -> Bool
    func computeHeight(for cell: UITableViewCell?, item: SceneItem?) -> CGFloat
    func reuseID(in section: Int, at row: Int) -> String
}

public extension Scene {
    
    public class Setup: SceneSetup {
        
        var theme: SceneTheme
        
        public init(theme: SceneTheme) {
            self.theme = theme
        }
        
        public func formatNavigationItem(_ navigationItem: UINavigationItem, title: String?) -> Bool {
            guard let title = title, !title.isEmpty else {
                return false
            }
            
            navigationItem.title = title
            return true
        }
        
        public func formatCell(_ cell: UITableViewCell, item: SceneItem?, action: SceneTableCellAction?) -> Bool {
            guard let cell = cell as? Scene.TableCell, item != nil else {
                return false
            }
            
            cell.action = action
            return true
        }
        
        public func computeHeight(for cell: UITableViewCell?, item: SceneItem?) -> CGFloat {
            guard let cell = cell as? Scene.TableCell, formatCell(cell, item: item, action: nil) else {
                return 0
            }
            
            return 44
        }
        
        public func reuseID(in section: Int, at row: Int) -> String {
            return "SceneTableCell"
        }
    }
}
