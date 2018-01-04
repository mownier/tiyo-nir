//
//  TextsSceneItem.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

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
