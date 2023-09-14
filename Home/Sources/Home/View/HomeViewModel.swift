//
//  File.swift
//  
//
//  Created by Kevin on 6/16/23.
//

import Foundation
@MainActor

public final class HomeViewModel: ObservableObject {
    @Published var movie: ListFilm?

    private var useCase: HomeUseCase

    public init(useCase: HomeUseCase) {
        self.useCase = useCase

    }

    
    struct Input {

    }

    struct Ouput {

    }

    func onAppearAction() async  {
        await getMovie()
    }

    private func getMovie() async {
       let movieCase = await useCase.getListMovies()
        switch movieCase {
        case .success(let movie):
            self.movie = movie
        case .failure(_):
            break
        }
    }
    

    
}
