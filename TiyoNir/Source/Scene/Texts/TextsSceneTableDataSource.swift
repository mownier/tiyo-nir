
import UIKit
import TNCore

extension TextsScene {
    
    class TableDataSource: NSObject, UITableViewDataSource {
        
        weak var cellAction: SceneTableCellAction?
        
        var data: TextsSceneData
        var cellFactory: TableCellFactory
        var setup: TextsSceneSetup
        
        init(data: TextsSceneData, cellFactory: TableCellFactory, setup: TextsSceneSetup) {
            self.data = data
            self.cellFactory = cellFactory
            self.setup = setup
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.itemCount
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
