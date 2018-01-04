//
//  TextsSceneData.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import Foundation

protocol TextsSceneData: class {
    
    var sceneTitle: String { get }
    var itemCount: Int { get }
    
    func item(at row: Int) -> SceneItem?
    func removeAll()
    func appendTexts(_ texts: [Text])
}

extension TextsScene {
    
    class Data: TextsSceneData {
        
        var items: [SceneItem] = []
        
        var sceneTitle: String = "Scene"
        
        var itemCount: Int {
            return items.count
        }
        
        func item(at row: Int) -> SceneItem? {
            guard row >= 0, row < itemCount else {
                return nil
            }
            
            return items[row]
        }
        
        func removeAll() {
            items.removeAll()
        }
        
        func appendTexts(_ texts: [Text]) {
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

