
import UIKit

public extension Scene {
    
    public class TableDataSource: NSObject, UITableViewDataSource {
        
        weak var cellAction: SceneTableCellAction?
        
        var data: SceneData
        var cellFactory: AppTableCellFactory
        var setup: SceneSetup
        
        public init(data: SceneData, cellFactory: AppTableCellFactory, setup: SceneSetup) {
            self.data = data
            self.cellFactory = cellFactory
            self.setup = setup
        }
        
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.itemCount
        }
        
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let section = indexPath.section
            let row = indexPath.row
            let reuseID = setup.reuseID(in: section, at: row)
            let cell = cellFactory.build(using: tableView, with: reuseID, in: section, at: row)
            let item = data.item(at: row)
            let _ = setup.formatCell(cell, item: item, action: cellAction)
            return cell
        }
    }
}
