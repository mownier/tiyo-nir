
import UIKit

public class Scene: UIViewController {
    
    var tableView: UITableView!
    
    var data: SceneData!
    var setup: SceneSetup!
    var theme: SceneTheme!
    var worker: SceneWorker!
    var interaction: SceneInteraction!
    
    var tableDelegate: UITableViewDelegate?
    var tableDataSource: UITableViewDataSource?
    var tableInjectables: [AppTableViewInjectable] = []
    
    public override func loadView() {
        super.loadView()
        
        view.backgroundColor = theme.bgColor
        
        tableView = UITableView()
        tableView.estimatedRowHeight = 0
        tableView.rowHeight = 0
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate
        
        view.addSubview(tableView)
        
        for injectable in tableInjectables {
            injectable.injectTableView(tableView)
        }
    }
    
    public override func viewDidLayoutSubviews() {
        var rect = CGRect.zero
        
        rect = view.bounds
        tableView.frame = rect
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        worker.fetchAllTexts()
    }
}

