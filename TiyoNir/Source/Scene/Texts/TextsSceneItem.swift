
struct SceneItem {
    
    var text: Text
    
    init(text: Text) {
        self.text = text
    }
}

extension SceneItem: Hashable {
    
    var hashValue: Int {
        return text.hashValue
    }
    
    static func ==(lhs: SceneItem, rhs: SceneItem) -> Bool {
        return lhs.text == rhs.text
    }
}
