
import UIKit

public class TextsScene: UIViewController {
    
    var tableView: UITableView!
    
    var data: TextsSceneData!
    var setup: TextsSceneSetup!
    var theme: TextsSceneTheme!
    var worker: TextsSceneWorker!
    var interaction: TextsSceneInteraction!
    
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
        
        let barItem = UIBarButtonItem(image: theme.backImage, style: .plain, target: interaction, action: #selector(interaction.didTapBack))
        navigationItem.leftBarButtonItem = barItem
        navigationItem.title = data.sceneTitle
        
        worker.fetchAllTexts()
    }
}

