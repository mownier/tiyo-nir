
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
        
        weak var output: SceneWorkerOutput?
        
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
        
        public class Output: SceneWorkerOutput {
            
            weak var tableView: UITableView?
            
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
            }
            
            public func workerDidFetchWithError(_ error: Error) {
                let _ = flow.showErrorScene(withError: error)
            }
        }
    }
}
