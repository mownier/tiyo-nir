
import UIKit

public extension TextsScene {
    
    public class TableDelegate: NSObject, UITableViewDelegate {
        
        var cellFactory: AppTableCellFactory
        
        var data: TextsSceneData
        var setup: TextsSceneSetup
        
        public init(data: TextsSceneData, cellFactory: AppTableCellFactory, setup: TextsSceneSetup) {
            self.data = data
            self.cellFactory = cellFactory
            self.setup = setup
        }
        
        public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let section = indexPath.section
            let row = indexPath.row
            let item = data.item(at: row)
            let prototype = cellFactory.prototype(in: section, at: row)
            let height = setup.computeHeight(for: prototype, item: item)
            return height
        }
    }
}
