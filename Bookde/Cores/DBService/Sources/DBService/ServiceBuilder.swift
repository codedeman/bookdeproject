//
//  File.swift
//  
//
//  Created by Kevin on 8/21/23.
//

import Foundation

public enum ServiceBuilder {
    public struct Output {
        public let dbClientService: DBServiceProtocol
        init(dbClientService: DBServiceProtocol) {
            self.dbClientService = dbClientService
        }
    }

    public static func buildAPIService() -> Output {
        let service = DBServiceImpl()
        return .init(dbClientService: service)
    }
}
