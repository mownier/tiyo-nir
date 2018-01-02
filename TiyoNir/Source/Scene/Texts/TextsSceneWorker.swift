
import UIKit

public protocol TextsSceneWorker: class {
    
    func fetchAllTexts()
}

public protocol TextsSceneWorkerOutput: class {
    
    func workerDidFetchTexts(_ texts: [Text])
    func workerDidFetchWithError(_ error: Error)
}

public extension TextsScene {
    
    public class Worker: TextsSceneWorker {
        
        var output: TextsSceneWorkerOutput?
        
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
        
        public class Output: TextsSceneWorkerOutput, TextsSceneDelegateInjectable, AppTableViewInjectable {
            
            weak var tableView: UITableView?
            var delegate: TextsSceneDelegate?
            
            var data: TextsSceneData
            var flow: TextsSceneFlow
            
            public init(data: TextsSceneData, flow: TextsSceneFlow) {
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
            
            public func injectDelegate(_ aDelegate: TextsSceneDelegate?) {
                delegate = aDelegate
            }
            
            public func injectTableView(_ aTableView: UITableView) {
                tableView = aTableView
            }
        }
    }
}
