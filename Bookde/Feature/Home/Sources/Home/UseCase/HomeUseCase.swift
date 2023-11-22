//
//  File.swift
//  
//
//  Created by Kevin on 8/9/23.
//

import Foundation
import DBService
import Combine
public protocol HomeUseCase {
    func getListMovies() async -> Result<ListFilm, ApiError>
}

public final class HomeUseCaseImpl: HomeUseCase {

    var repository: HomeRespository

    public init(repository: HomeRespository) {
        self.repository = repository
    }

    public func getListMovies() async -> Result<ListFilm, ApiError> {

        let movie =  await repository.getAllMovie()
        switch movie {
        case let .success(response):
            return .success(response)
        case let .failure(getMovieError):
            return .failure(.jsonParsingFailure)
        }
    }

}

