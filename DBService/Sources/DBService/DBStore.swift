//
//  File.swift
//  
//
//  Created by Kevin on 8/19/23.
//

import Foundation

protocol DBStoragesProtocol {
    associatedtype T

    func save(entity: T)
    func delete(entity: T)

}
