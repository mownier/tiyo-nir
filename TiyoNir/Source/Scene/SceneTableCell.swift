
import UIKit

public protocol SceneTableCellAction: class {
    
}

public extension Scene {
    
    public class TableCell: UITableViewCell {
    
        public weak var action: SceneTableCellAction?
    }
}
