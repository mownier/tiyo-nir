//
//  TextRemoteQuery.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import TNCore

public final class TextRemoteQuery: TextQuery {
    
    public func getTexts(for textIDs: [String], completion: @escaping (Result<[Text]>) -> Void) {
        var texts = [Text]()
        var text = Text()
        text.id = "text:1"
        text.content = "Hello World!"
        texts.append(text)
        completion(.ok(texts))
    }
    
    public func getAllTexts(completion: @escaping (Result<[Text]>) -> Void) {
        var texts = [Text]()
        var text = Text()
        text.id = "text:1"
        text.content = "Hello World!"
        texts.append(text)
        completion(.ok(texts))
    }
}
