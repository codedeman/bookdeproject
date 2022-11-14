//
//  SwiftUIView.swift
//  
//
//  Created by Kevin on 6/14/23.
//

import SwiftUI

struct AppartmentView: View {
    @EnvironmentObject var modelData: DBHome
    var rentingData: ApartmentRenting
    var body: some View {
        VStack {
            rentingData
                .image
                .resizable()
                .aspectRatio( contentMode: .fit )
                .cornerRadius(10)
        }

    }
}

