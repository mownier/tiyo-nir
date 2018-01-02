
import UIKit

public protocol SceneFactory: class {
    
    func withTheme(_ theme: SceneTheme) -> SceneFactory & AppSceneFactory
    func withDelegate(_ delegate: SceneDelegate?) -> SceneFactory & AppSceneFactory
}

public extension Scene {
    
    public class Factory: SceneFactory, AppSceneFactory {
        
        class Injector {
            
            var scene: SceneInjector
            var theme: SceneThemeInjector
            var delegate: SceneDelegateInjector
            
            init() {
                self.scene = SceneInjector()
                self.theme = SceneThemeInjector()
                self.delegate = SceneDelegateInjector()
            }
        }
        
        class Injectable {
            
            var scenes: [AppSceneInjectable]
            var themes: [SceneThemeInjectable]
            var delegates: [SceneDelegateInjectable]
            var tables: [AppTableViewInjectable]
            
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
        
        var data: SceneData!
        var setup: SceneSetup!
        var theme: SceneTheme!
        var worker: SceneWorker!
        var delegate: SceneDelegate?
        var interaction: SceneInteraction!
        var tableDelegate: UITableViewDelegate!
        var tableDataSource: UITableViewDataSource!
        
        var injector: Injector!
        var injectable: Injectable!
        
        public init() {
            let flow = Flow()
            let data = Data()
            let theme = Theme()
            let setup = Setup(theme: theme)
            let worker = Worker()
            let waypoint = Waypoint.Exit()
            let interaction = Interaction()
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
            self.injectable.scenes.append(waypoint)
            self.injectable.themes.append(cellLaborer)
            self.injectable.themes.append(setup)
            self.injectable.tables.append(workerOutput)
            self.injectable.delegates.append(workerOutput)
        }
        
        public func build() -> UIViewController {
            let scene = Scene()
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
        
        public func withTheme(_ aTheme: SceneTheme) -> SceneFactory & AppSceneFactory {
            theme = aTheme
            return self
        }
        
        public func withDelegate(_ aDelegate: SceneDelegate?) -> SceneFactory & AppSceneFactory {
            delegate = aDelegate
            return self
        }
    }
}

