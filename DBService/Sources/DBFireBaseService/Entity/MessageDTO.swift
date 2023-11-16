//
//  File.swift
//  
//
//  Created by Kevin on 11/16/23.
//

import Foundation

public struct MessageDTO {
    public var toId: String
    public var fromId: String
    public var text: String
    public var timesstamp: String
    public init(json: [String: Any]) {
        self.fromId = json["fromId"] as? String ?? ""
        self.toId = json["toId"] as? String ?? ""
        self.text = json["text"] as? String ?? ""
        self.timesstamp = json["timesstamp"] as? String ?? ""
    }
}
