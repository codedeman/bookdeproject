//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 6/13/23.
//

import SwiftUI

public struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var isLoading = true

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {

        List {

//                HStack{
                    ForEach((viewModel.movie?.listFilms ?? []), id: \.self) { film in
                        MoviekRow(movie: film)
                    }
//                }
        }.task {
            await viewModel.onAppearAction()
        }
    }
}

struct MoviekRow: View {
    var movie: Movies


    var body: some View {
        HStack {
            AsyncImage(url: URL.init(string: movie.filmUrl))
                .frame(width: 50,height: 50)
                .scaledToFit().padding(.leading,16)
            Spacer()

            Text(movie.name)
                            .padding(.leading, 16)
            Spacer()
        }
    }
}
