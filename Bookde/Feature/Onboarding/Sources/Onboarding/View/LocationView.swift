//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 6/12/23.
//

import SwiftUI

struct LocationView: View {
    var body: some View {
        VStack {
            Image("2.jpg")
            Text("Hi location here")
                .font(.title)
                .bold()
        }
    }
}


struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
