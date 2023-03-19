//
//  ContentView.swift
//  Assist Pro Manager
//
//  Created by Jean on 3/14/23.
//

import SwiftUI


struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
                
                VStack {
                    
                    Text("Assist Pro Manager")
                        .foregroundColor(.yellow)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .background(Color.black)
                    
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width:300, height: 50)
                        .background(Color.white.opacity(0.99))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width:300, height: 50)
                        .background(Color.white.opacity(0.99))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    
                    Button("Login") {
                        
                        authenticateUser(username: username, password: password)
                        
                    }
                    
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    
                    
                    
                }
                .background {
                    Image("titlebackground3")
                }
                .scrollContentBackground(.hidden)
                .interactiveDismissDisabled()
            
            
        }
        .navigationBarHidden(true)
    }
    func authenticateUser(username: String, password: String) {
        if username.lowercased() == "zerato2023" {
            wrongUsername = 0
            if password.lowercased() == "abc123" {
                wrongPassword = 0
                showingLoginScreen = true
            } else {
                wrongPassword = 2
              
            }
        } else {
            wrongUsername = 2
        }
        presentationMode.wrappedValue.dismiss()
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
}
