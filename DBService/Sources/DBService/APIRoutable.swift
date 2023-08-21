//
//  File.swift
//  
//
//  Created by Kevin on 8/15/23.
//

import Foundation

public protocol APIRoutable {
    var path: String { get }
    var baseURl: URL { get }
    
}
