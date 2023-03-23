//
//  ContentView.swift
//  Assist Pro Manager
//
//  Created by Jean on 3/14/23.
//

import SwiftUI

struct User: Encodable {
    var username: String = ""
    var email: String = ""
    var password: String = ""
}

struct Response: Codable {
    var user: ResponseUser?
    var token: String
    struct ResponseUser: Codable {
        var id: Int
        var username: String
        var email: String
        
    }
}

struct LoginView: View {
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var isNewUser = false
    @State var isDisplayingHome: Bool = false
    @KeychainStorage("MyToken") var savedToken = ""
    @State private var user: User = User()
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
                
                TextField("Username", text: $user.username)
                    .colorScheme(.light)
                    .bold()
                    .padding()
                    .frame(width:300, height: 50)
                    .background(Color.white.opacity(0.99))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                
                if isNewUser {
                    TextField("Email", text: $user.email)
                        .colorScheme(.light)
                        .bold()
                        .padding()
                        .frame(width:300, height: 50)
                        .background(Color.white.opacity(0.99))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                }
                
                
                SecureField("Password", text: $user.password)
                    .colorScheme(.light)
                    .padding()
                    .frame(width:300, height: 50)
                    .background(Color.white.opacity(0.99))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                
                
                Button(isNewUser ? "Create Account" : "Login") {
                    Task {
                        if isNewUser {
                            await signUp(user: user)
                        } else {
                            await logIn(user: user)
                        }
                    }
                    
                }
                
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                
                Button(isNewUser ? "Switch To Login" : "New User") {
                    isNewUser.toggle()
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
                Image("loginBackground4")
            }
            .scrollContentBackground(.hidden)
            .interactiveDismissDisabled()
        }
        
        .fullScreenCover(isPresented: $isDisplayingHome) {
            HomeView()
            
        }
        .navigationBarHidden(true)
    }
    
    
    func logIn(user: User) async {
        
        guard let encodedUser = try? JSONEncoder().encode(user) else { return }
        let url = URL(string: "https://project-5-mlyi.onrender.com/api/login/")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedUser)
            print(String(data: data, encoding: .utf8))
            let response = try JSONDecoder().decode(Response.self, from: data)
            savedToken = response.token
            presentationMode.wrappedValue.dismiss()
            
        } catch {
            print(error )
            
        }
    }
    
    
    func signUp(user: User) async {
        guard let encodedUser = try? JSONEncoder().encode(user) else { return }
        let url = URL(string: "https://project-5-mlyi.onrender.com/api/register/")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedUser)
            print(String(data: data, encoding: .utf8))
            let response = try JSONDecoder().decode(Response.self, from: data)
            savedToken = response.token
            print(savedToken)
            presentationMode.wrappedValue.dismiss()
            
        } catch {
            print(error)
            
        }
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

