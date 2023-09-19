//
//  DBCoreFireBase.swift
//  
//
//  Created by Kevin on 9/19/23.
//

import Foundation

public struct AppError: Error, CustomDebugStringConvertible, Equatable {
    public var debugDescription: String

    public init(_ description: String) {
        self.debugDescription = description
    }

}

public extension AppError {
    static let genericError = AppError("The operation die at the moment")
}
