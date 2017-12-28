//
//  TextRemoteService.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

public final class TextRemoteService {
    
    public let query: TextQuery
    public let writer: TextWriter
    
    public init(query: TextQuery, writer: TextWriter) {
        self.query = query
        self.writer = writer
    }
    
    public convenience init() {
        let query = TextRemoteQuery()
        let writer = TextRemoteWriter()
        self.init(query: query, writer: writer)
    }
}
