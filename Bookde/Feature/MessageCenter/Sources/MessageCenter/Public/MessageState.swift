//
//  MessageState.swift
//  
//
//  Created by Kevin on 11/11/23.
//

import Combine

public final class MessageState: ObservableObject {

    @Published public var id: String = ""
    @Published public var didSelectBack = false

    public init(id: String) {
        self.id = id
    }
}
