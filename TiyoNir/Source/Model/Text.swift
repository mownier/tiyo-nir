//
//  Text.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

public struct Text {

    public var id: String
    public var content: String

    public init() {
        self.id = ""
        self.content = ""
    }
}

extension Text: Hashable {
    
    public var hashValue: Int {
        return id.hashValue
    }
    
    public static func ==(lhs: Text, rhs: Text) -> Bool {
        return !lhs.id.isEmpty && !rhs.id.isEmpty && lhs.id == rhs.id
    }
}
