//
//  ManagerView.swift
//  Assist Pro Manager
//
//  Created by Jean on 3/20/23.
//

import SwiftUI

struct ManagerView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var isDisplayingNewProject: Bool = false
    @State var isDisplayingLogin: Bool = false
    @State var isDisplayingHome: Bool = false
    @State var isDisplayingAbout: Bool = false
    @KeychainStorage("MyToken") var savedToken: String?
    var body: some View {
        
        VStack{
            Image(systemName: "list.bullet.circle")
                .padding(.bottom)
                .font(.system(size:60))
            
            Button(){
                isDisplayingHome = true
            } label: {
                Text("Projects")
                    .foregroundColor(.white)
                    .frame(maxWidth: 300, minHeight: 40)
                    .background(LinearGradient(colors: [.blue,.pink],
                                               startPoint: .leading, endPoint: .trailing))
                    .clipShape(Capsule())
            }
            
            
            Button(){
                isDisplayingNewProject = true
            } label: {
                Text("New Project")
                    .foregroundColor(.white)
                    .frame(maxWidth: 300, minHeight: 40)
                    .background(LinearGradient(colors: [.blue,.pink],
                                               startPoint: .leading, endPoint: .trailing))
                    .clipShape(Capsule())
            }
            
            
            Button(){
                
            } label: {
                Text("User Profile")
                    .foregroundColor(.white)
                    .frame(maxWidth: 300, minHeight: 40)
                    .background(LinearGradient(colors: [.blue,.pink],
                                               startPoint: .leading, endPoint: .trailing))
                    .clipShape(Capsule())
            }
            
            
            Button(){
                
            } label: {
                Text("Reset Password")
                .foregroundColor(.white)
                .frame(maxWidth: 300, minHeight: 40)
                .background(LinearGradient(colors: [.blue,.pink],
                                           startPoint: .leading, endPoint: .trailing))
                .clipShape(Capsule())
            }
            
            
            Button(){
                isDisplayingAbout = true
            }label: {
                Text("About")
                    .foregroundColor(.white)
                    .frame(maxWidth: 300, minHeight: 40)
                    .background(LinearGradient(colors: [.blue,.pink],
                                               startPoint: .leading, endPoint: .trailing))
                    .clipShape(Capsule())
            }
            
            
            Button(){
                savedToken = nil
                isDisplayingLogin = true
            } label: {
                Text("Log Out")
                    .foregroundColor(.white)
                    .frame(maxWidth: 300, minHeight: 40)
                    .background(LinearGradient(colors: [.blue,.pink],
                                               startPoint: .leading, endPoint: .trailing))
                    .clipShape(Capsule())
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight:  .infinity)
        .background(Color(uiColor: UIColor.systemBackground)
        )
        .sheet(isPresented: $isDisplayingNewProject) {
            ProjectFormView(isNewProject: true, project: Project())
        }
        .fullScreenCover(isPresented: $isDisplayingLogin) {
            LoginView()
        }
        .fullScreenCover(isPresented: $isDisplayingHome) {
            HomeView()
        }
        .sheet(isPresented: $isDisplayingAbout) {
            AboutPage()
        }
    }
    
    
    
    struct ManagerView_Previews: PreviewProvider {
        static var previews: some View {
            ManagerView()
        }
    }
}
