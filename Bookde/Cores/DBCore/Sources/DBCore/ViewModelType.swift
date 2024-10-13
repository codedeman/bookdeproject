//
//  File.swift
//  
//
//  Created by Kevin on 10/12/24.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input, cancelBag: CancelBag) -> Output
}
