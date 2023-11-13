//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 11/9/23.
//

import SwiftUI

public struct NewMessageView: View {

    @ObservedObject var viewModel: NewMessageViewModel

    public init (viewModel: NewMessageViewModel) {
        self.viewModel = viewModel
    }

    @State var textMessage: String = ""
    public var body: some View {
        ScrollView {
            ForEach(0..<10) { num in
                HStack {
                    Spacer()
                    HStack {
                        Text("Message ABC")
                            .foregroundColor(Color.white)
                    }.padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }.padding(.horizontal)
                    .padding(.top,8)
            }

        }.navigationTitle("hello")
        HStack{ Spacer() }
        HStack {
            Image(systemName: "gear")
            TextField("Description", text: $textMessage)
            Button {

            }label: {
                Text("Send").foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical,8)
            .background(Color.blue)
                .cornerRadius(8)
        }.padding()
    }
}

#Preview {
    NewMessageView(viewModel: .init(usecase: ImplMessageUseCase()))
}
