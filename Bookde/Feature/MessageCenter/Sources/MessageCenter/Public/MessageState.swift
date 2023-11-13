//
//  MessageState.swift
//  
//
//  Created by Kevin on 11/11/23.
//

import DBCore

public enum MessageState: StateManager {
    case startCreateNewMessage(users: User)
    case none
}
