
import UIKit

public protocol SceneDelegate: class {
    
}

public class Scene: UIViewController {
    
    let table: AppTable
    
    let data: SceneData
    let setup: SceneSetup
    let theme: SceneTheme
    let worker: SceneWorker
    let interaction: SceneInteraction
    
    public weak var delegate: SceneDelegate?
    
    public init(theme: SceneTheme, interaction: SceneInteraction, table: AppTable, setup: SceneSetup, data: SceneData, worker: SceneWorker) {
        self.theme = theme
        self.interaction = interaction
        self.table = table
        self.setup = setup
        self.data = data
        self.worker = worker
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init() {
        let theme = Theme()
        let data = Data()
        let waypoint = Waypoint.Exit()
        let flow = Flow()
        let worker = Worker()
        
        let output = Worker.Output(data: data, flow: flow)
        let setup = Setup(theme: theme)
        let interaction = Interaction(waypoint: waypoint)
        
        let tableCellFactory = TableCellFactory(theme: theme)
        let tableDelegate = TableDelegate(data: data, cellFactory: tableCellFactory, setup: setup)
        let tableDataSource = TableDataSource(data: data, cellFactory: tableCellFactory, setup: setup)
        let table = AppTable(delegate: tableDelegate, dataSource: tableDataSource, cellFactory: tableCellFactory)
        
        self.init(theme: theme, interaction: interaction, table: table, setup: setup, data: data, worker: worker)
        
        output.tableView = table.view
        worker.output = output
        waypoint.scene = self
        flow.scene = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        let theme = Theme()
        let data = Data()
        let waypoint = Waypoint.Exit()
        let flow = Flow()
        let worker = Worker()
        
        let output = Worker.Output(data: data, flow: flow)
        let setup = Setup(theme: theme)
        let interaction = Interaction(waypoint: waypoint)
        
        let tableCellFactory = TableCellFactory(theme: theme)
        let tableDelegate = TableDelegate(data: data, cellFactory: tableCellFactory, setup: setup)
        let tableDataSource = TableDataSource(data: data, cellFactory: tableCellFactory, setup: setup)
        let table = AppTable(delegate: tableDelegate, dataSource: tableDataSource, cellFactory: tableCellFactory)
        
        self.theme = theme
        self.interaction = interaction
        self.table = table
        self.setup = setup
        self.data = data
        self.worker = worker
        
        super.init(coder: aDecoder)
        
        output.tableView = table.view
        worker.output = output
        waypoint.scene = self
        flow.scene = self
    }
    
    public override func loadView() {
        super.loadView()
        
        view.backgroundColor = theme.bgColor
        
        table.view.estimatedRowHeight = 0
        table.view.rowHeight = 0
        table.view.separatorStyle = .none
        table.view.tableFooterView = UIView()
        
        view.addSubview(table.view)
    }
    
    public override func viewDidLayoutSubviews() {
        var rect = CGRect.zero
        
        rect = view.bounds
        table.view.frame = rect
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let back = UIBarButtonItem(image: #imageLiteral(resourceName: "button_back"), style: .plain, target: interaction, action: #selector(interaction.didTapBack))
        navigationItem.leftBarButtonItem = back
        
        let _ = setup.formatNavigationItem(navigationItem, title: data.sceneTitle)
        
        worker.fetchAllTexts()
    }
}

