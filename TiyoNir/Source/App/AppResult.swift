//
//  AppResult.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

public enum AppResult<T> {

    case ok(T)
    case err(Error)
}

public struct AppError {
    
    public let message: String
    
    public init(_ message: String) {
        self.message = message
    }
}
