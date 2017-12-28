//
//  TextWriter.swift
//  TiyoNir
//
//  Created by Mounir Ybanez on 12/28/17.
//  Copyright © 2017 Nir. All rights reserved.
//

import UIKit

public protocol TextWriter: class {

    func writeText(withContent content: String, completion: (Text) -> Void)
}
