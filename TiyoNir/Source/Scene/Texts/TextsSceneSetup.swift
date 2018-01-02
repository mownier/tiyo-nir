
import UIKit

public protocol TextsSceneSetup: class {
    
    func formatCell(_ cell: UITableViewCell, item: SceneItem?, action: SceneTableCellAction?) -> Bool
    func computeHeight(for cell: UITableViewCell?, item: SceneItem?) -> CGFloat
    func reuseID(in section: Int, at row: Int) -> String
}

public extension TextsScene {
    
    public class Setup: TextsSceneSetup, TextsSceneThemeInjectable {
        
        var theme: TextsSceneTheme
        
        public init(theme: TextsSceneTheme) {
            self.theme = theme
        }
        
        public func formatCell(_ cell: UITableViewCell, item: SceneItem?, action: SceneTableCellAction?) -> Bool {
            guard let cell = cell as? TextsScene.TableCell, item != nil else {
                return false
            }
            
            cell.action = action
            return true
        }
        
        public func computeHeight(for cell: UITableViewCell?, item: SceneItem?) -> CGFloat {
            guard let cell = cell as? TextsScene.TableCell, formatCell(cell, item: item, action: nil) else {
                return 0
            }
            
            return 44
        }
        
        public func reuseID(in section: Int, at row: Int) -> String {
            return "SceneTableCell"
        }
        
        public func injectTheme(_ aTheme: TextsSceneTheme) {
            theme = aTheme
        }
    }
}
