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
    @State var isDisplayingHome: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            
            VStack {
                // PROPERTIES
                Text("Assist Pro Manager")
                    .foregroundColor(.yellow)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .background(Color.black)
                    .cornerRadius(20)
                
                TextField("Username", text: $username)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width:300, height: 50)
                    .background(Color.white.opacity(0.99))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                
                SecureField("Password", text: $password)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width:300, height: 50)
                    .background(Color.white.opacity(0.99))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                
                
                Button("Login") {
                    isDisplayingHome = true
                    authenticateUser(username: username, password: password)
                    
                }
                
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                
                Button("New User") {
                    
                }
                
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.red)
                .cornerRadius(10)
                
                Button("Forgot Password") {
                    
                }
                
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.red)
                .cornerRadius(10)
                
                
            }
            .background {
                Image("titlebackground3")
            }
            .scrollContentBackground(.hidden)
            .interactiveDismissDisabled()
        }
        
            .fullScreenCover(isPresented: $isDisplayingHome) {
                HomeView()
            
        }
        .navigationBarHidden(true)
    }
    
   
        
            
            
    func authenticateUser(username: String, password: String) {
        // access request body( username, password)
        // send a post request to our server
        // insure request is sending a json body
        // capture the response of the request using the token value in our code
        // 
        
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
        
        }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }

