
import UIKit

public protocol SceneTableCellAction: class {
    
}

public extension TextsScene {
    
    public class TableCell: UITableViewCell {
    
        public weak var action: SceneTableCellAction?
    }
}
