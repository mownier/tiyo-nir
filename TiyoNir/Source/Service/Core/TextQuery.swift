//
//  TextQuery.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import TNCore

public protocol TextQuery: class {

    func getAllTexts(completion: @escaping (Result<[Text]>) -> Void)
    func getTexts(for textIDs: [String], completion: @escaping (Result<[Text]>) -> Void)
}

