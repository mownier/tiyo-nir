
import UIKit

public final class AppTable {
    
    public let view: UITableView
    public let cellFactory: AppTableCellFactory
    
    public init(tableViewFactory: AppTableViewFactory, delegate: UITableViewDelegate?, dataSource: UITableViewDataSource?, cellFactory: AppTableCellFactory) {
        let view = tableViewFactory.build()
        view.dataSource = dataSource
        view.delegate = delegate
        self.view = view
        self.cellFactory = cellFactory
    }
    
    public convenience init(delegate: UITableViewDelegate?, dataSource: UITableViewDataSource?, cellFactory: AppTableCellFactory) {
        let tableViewFactory = UITableView.Factory(style: .plain)
        self.init(tableViewFactory: tableViewFactory, delegate: delegate, dataSource: dataSource, cellFactory: cellFactory)
    }
}

