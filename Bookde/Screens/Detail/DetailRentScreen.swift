//
//  DetailRentScreen.swift
//  Bookde
//
//  Created by Kevin on 11/14/22.
//

import SwiftUI

struct DetailRentScreen: View {
    @EnvironmentObject var modelData: ModelData

    var rentingData: ListRenting
    var body: some View {
        VStack {
            rentingData.image.resizable().aspectRatio( contentMode: .fit).cornerRadius(10)
        }
        
    }
}


