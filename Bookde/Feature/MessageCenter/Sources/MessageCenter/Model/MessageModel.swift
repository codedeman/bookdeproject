//
//  MessageModel.swift
//  
//
//  Created by Kevin on 10/28/23.
//


import Foundation

struct MessageModel: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
