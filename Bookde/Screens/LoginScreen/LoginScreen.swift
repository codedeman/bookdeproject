//
//  LoginScreen.swift
//  Bookde
//
//  Created by Kevin on 11/14/22.
//

import SwiftUI

struct LoginScreen: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack(alignment: .center,spacing: 15) {
            
            Text("Well come to BookDe").font(.largeTitle).foregroundColor(.white).padding([.top,.bottom],40)
                .padding([.leading,.trailing], 30)
                .shadow(radius: 10.0, x: 20, y: 10)
            TextField("Email", text: self.$email).padding().background(Color.themeTextField).cornerRadius(20.0).padding([.leading,.trailing])
            SecureField("Pass word",text: self.$password)
                .padding().background(Color.themeTextField).cornerRadius(20.0).padding([.leading,.trailing])
            Button(action: {}) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.pink)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }.padding(.top, 10)
            HStack(spacing: 0) {
                Text("Don't have an account? ").foregroundColor(.white)
                Button(action: {}) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                }
            }
            Text("OR").font(.subheadline).foregroundColor(.white)
            AuthenTypeScreen()
            Spacer()


        }.background(
            LinearGradient(gradient: Gradient(colors: [.pink, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
    }
}

struct AuthenTypeScreen: View {
    var body: some View {
        HStack {
            Button (action: {}) {
                Image("ic_vetc").frame(width: 50,height: 50)
            }
            Image("ic_vetc").frame(width: 50,height: 50)
            Image("ic_vetc").frame(width: 50,height: 50)

        }
    }
}


extension Color {
    static var themeTextField: Color {
        return Color(red: 220.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, opacity: 1.0)
    }
}
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
//        AuthenTypeScreen()
    }
}
