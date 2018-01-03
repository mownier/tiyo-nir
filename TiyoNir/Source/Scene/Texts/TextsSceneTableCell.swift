
import UIKit

protocol SceneTableCellAction: class {
    
}

extension TextsScene {
    
    class TableCell: UITableViewCell {
    
        weak var action: SceneTableCellAction?
    }
}
