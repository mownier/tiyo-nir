
import UIKit

public protocol SceneWorker: class {
    
    func fetchAllTexts()
}

public protocol SceneWorkerOutput: class {
    
    func workerDidFetchTexts(_ texts: [Text])
    func workerDidFetchWithError(_ error: Error)
}

public extension Scene {
    
    public class Worker: SceneWorker {
        
        var output: SceneWorkerOutput?
        
        let query: TextQuery
        
        public init(query: TextQuery) {
            self.query = query
        }
        
        public convenience init() {
            let service = TextRemoteService()
            self.init(query: service.query)
        }
        
        public func fetchAllTexts() {
            query.getAllTexts { [weak self] result in
                switch result {
                case .err(let error):
                    self?.output?.workerDidFetchWithError(error)
                
                case.ok(let texts):
                    self?.output?.workerDidFetchTexts(texts)
                }
            }
        }
        
        public class Output: SceneWorkerOutput, SceneDelegateInjectable, AppTableViewInjectable {
            
            weak var tableView: UITableView?
            var delegate: SceneDelegate?
            
            var data: SceneData
            var flow: SceneFlow
            
            public init(data: SceneData, flow: SceneFlow) {
                self.data = data
                self.flow = flow
            }
            
            public func workerDidFetchTexts(_ texts: [Text]) {
                data.removeAll()
                data.appendTexts(texts)
                tableView?.reloadData()
                
                delegate?.sceneDidFetchTexts(texts)
            }
            
            public func workerDidFetchWithError(_ error: Error) {
                let _ = flow.showErrorScene(withError: error)
            }
            
            public func injectDelegate(_ aDelegate: SceneDelegate?) {
                delegate = aDelegate
            }
            
            public func injectTableView(_ aTableView: UITableView) {
                tableView = aTableView
            }
        }
    }
}
