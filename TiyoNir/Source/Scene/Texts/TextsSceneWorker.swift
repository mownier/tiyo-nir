
import UIKit
import TNCore

protocol TextsSceneWorker: class {
    
    func fetchAllTexts()
}

protocol TextsSceneWorkerOutput: class {
    
    func workerDidFetchTexts(_ texts: [Text])
    func workerDidFetchWithError(_ error: Swift.Error)
}

extension TextsScene {
    
    class Worker: TextsSceneWorker {
        
        var output: TextsSceneWorkerOutput?
        
        let query: TextQuery
        
        init(query: TextQuery) {
            self.query = query
        }
        
        convenience init() {
            let service = TextRemoteService()
            self.init(query: service.query)
        }
        
        func fetchAllTexts() {
            query.getAllTexts { [weak self] result in
                switch result {
                case .err(let error):
                    self?.output?.workerDidFetchWithError(error)
                
                case.ok(let texts):
                    self?.output?.workerDidFetchTexts(texts)
                }
            }
        }
        
        class Output: TextsSceneWorkerOutput, TextsSceneDelegateInjectable, TableViewInjectable {
            
            weak var tableView: UITableView?
            weak var delegate: TextsSceneDelegate?
            
            var data: TextsSceneData
            var flow: TextsSceneFlow
            
            init(data: TextsSceneData, flow: TextsSceneFlow) {
                self.data = data
                self.flow = flow
            }
            
            func workerDidFetchTexts(_ texts: [Text]) {
                data.removeAll()
                data.appendTexts(texts)
                tableView?.reloadData()
                
                delegate?.sceneDidFetchTexts(texts)
            }
            
            func workerDidFetchWithError(_ error: Swift.Error) {
                let _ = flow.showErrorScene(withError: error)
            }
            
            func injectDelegate(_ aDelegate: TextsSceneDelegate?) {
                delegate = aDelegate
            }
            
            func injectTableView(_ aTableView: UITableView) {
                tableView = aTableView
            }
        }
    }
}
