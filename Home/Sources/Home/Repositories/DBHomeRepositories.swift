//
//  File.swift
//  
//
//  Created by Kevin on 8/15/23.
//

import Foundation
import DBService

struct MovieModelRequest: APIRoutable {
    var path: String
    var baseURl: URL
    
    init(path: String, baseURl: URL) {
        self.path = path
        self.baseURl = baseURl
    }
}
 
public protocol HomeRespository {
     func getAllMovie() async -> Result<ListFilm, ApiError>
}

public final class DBHomeRespositoryImpl: HomeRespository {
    private let apiService: DBServiceProtocol
    
    public init(apiService: DBServiceProtocol) {
        self.apiService = apiService
    }
    
    public func getAllMovie() async  -> Result<ListFilm, ApiError> {
        let request = MovieModelRequest.init(path: "", baseURl: URL(string: "https://codedeman.github.io/ssd_api/fakeCinema.json")!)
        return await apiService.request(
            request,
            type: ListFilm.self
        )
    }
}
