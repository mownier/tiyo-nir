//
//  TextQuery.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

public protocol TextQuery: class {

    func getAllTexts(completion: (AppResult<[Text]>) -> Void)
    func getTexts(for textIDs: [String], completion: (AppResult<[Text]>) -> Void)
}

