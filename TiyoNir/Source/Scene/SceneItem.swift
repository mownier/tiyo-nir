
public struct SceneItem {
    
    public var text: Text
    
    public init(text: Text) {
        self.text = text
    }
}

extension SceneItem: Hashable {
    
    public var hashValue: Int {
        return text.hashValue
    }
    
    public static func ==(lhs: SceneItem, rhs: SceneItem) -> Bool {
        return lhs.text == rhs.text
    }
}
