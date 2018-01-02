
import Foundation

public protocol TextsSceneData: class {
    
    var sceneTitle: String { get }
    var itemCount: Int { get }
    
    func item(at row: Int) -> SceneItem?
    func removeAll()
    func appendTexts(_ texts: [Text])
}

public extension TextsScene {
    
    public class Data: TextsSceneData {
        
        var items: [SceneItem] = []
        
        public var sceneTitle: String {
            return "Scene"
        }
        
        public var itemCount: Int {
            return items.count
        }
        
        public func item(at row: Int) -> SceneItem? {
            guard row >= 0, row < itemCount else {
                return nil
            }
            
            return items[row]
        }
        
        public func removeAll() {
            items.removeAll()
        }
        
        public func appendTexts(_ texts: [Text]) {
            let texts = Array(Set(texts))
            
            let mapped = texts.map({ SceneItem(text: $0) })
            let old = mapped.filter({ items.contains($0) })
            let new = mapped.filter({ !items.contains($0) })
            
            for item in old {
                guard let index = items.index(of: item) else {
                    continue
                }
                
                items[index] = item
            }
            
            items.append(contentsOf: new)
        }
    }
}

