
import UIKit
import TNCore

public protocol TextsSceneFactory: class {
    
    func withTheme(_ theme: TextsSceneTheme) -> SceneFactory & TextsSceneFactory
    func withDelegate(_ delegate: TextsSceneDelegate?) -> SceneFactory & TextsSceneFactory
}

public extension TextsScene {
    
    public class Factory: TextsSceneFactory, SceneFactory {
        
        class Injector {
            
            var scene: SceneInjector
            var theme: TextsSceneThemeInjector
            var delegate: TextsSceneDelegateInjector
            
            init() {
                self.scene = SceneInjector()
                self.theme = TextsSceneThemeInjector()
                self.delegate = TextsSceneDelegateInjector()
            }
        }
        
        class Injectable {
            
            var scenes: [SceneInjectable]
            var themes: [TextsSceneThemeInjectable]
            var delegates: [TextsSceneDelegateInjectable]
            var tables: [TableViewInjectable]
            
            init() {
                self.scenes = []
                self.themes = []
                self.delegates = []
                self.tables = []
            }
            
            func removeAll() {
                scenes.removeAll()
                themes.removeAll()
                delegates.removeAll()
                tables.removeAll()
            }
        }
        
        var data: TextsSceneData!
        var setup: TextsSceneSetup!
        var theme: TextsSceneTheme!
        var worker: TextsSceneWorker!
        var delegate: TextsSceneDelegate?
        var interaction: TextsSceneInteraction!
        var tableDelegate: UITableViewDelegate!
        var tableDataSource: UITableViewDataSource!
        
        var injector: Injector!
        var injectable: Injectable!
        
        public init(waypoint: ExitWaypoint) {
            let flow = Flow()
            let data = Data()
            let theme = Theme()
            let setup = Setup(theme: theme)
            let worker = Worker()
            let interaction = Interaction(waypoint: waypoint)
            let cellLaborer = TableCellLaborer(theme: theme, isHeightDynamic: true)
            let cellFactory = TableCellFactory(laborer: cellLaborer)
            let workerOutput = Worker.Output(data: data, flow: flow)
            let tableDelegate = TableDelegate(data: data, cellFactory: cellFactory, setup: setup)
            let tableDataSource = TableDataSource(data: data, cellFactory: cellFactory, setup: setup)
            
            worker.output = workerOutput
            
            self.data = data
            self.theme = theme
            self.setup = setup
            self.worker = worker
            self.interaction = interaction
            self.tableDelegate = tableDelegate
            self.tableDataSource = tableDataSource
            
            self.injector = Injector()
            self.injectable = Injectable()
            
            self.injectable.scenes.append(flow)
            self.injectable.themes.append(cellLaborer)
            self.injectable.themes.append(setup)
            self.injectable.tables.append(workerOutput)
            self.injectable.delegates.append(workerOutput)
        }
        
        public func build() -> UIViewController {
            let scene = TextsScene()
            scene.data = data
            scene.setup = setup
            scene.theme = theme
            scene.worker = worker
            scene.interaction = interaction
            scene.tableDelegate = tableDelegate
            scene.tableDataSource = tableDataSource
            
            for injectable in injectable.scenes {
                injector.scene.injectScene(scene, using: injectable)
            }
            
            for injectable in injectable.delegates {
                injector.delegate.injectDelegate(delegate, using: injectable)
            }
            
            for injectable in injectable.themes {
                injector.theme.injectTheme(theme, using: injectable)
            }
            
            return scene
        }
        
        public func withTheme(_ aTheme: TextsSceneTheme) -> SceneFactory & TextsSceneFactory {
            theme = aTheme
            return self
        }
        
        public func withDelegate(_ aDelegate: TextsSceneDelegate?) -> SceneFactory & TextsSceneFactory {
            delegate = aDelegate
            return self
        }
    }
}

