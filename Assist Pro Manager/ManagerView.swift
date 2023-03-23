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
    var body: some View {
        
        VStack{
            Image(systemName: "list.bullet.circle")
                .padding(.bottom)
                .font(.system(size:60))
            
            Button("Projects"){
                isDisplayingHome = true
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            .bold()
            
            Button("New Project"){
                isDisplayingNewProject = true
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            .bold()
            
            Button("User Profile"){
                
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            .bold()
            
            Button("Reset Password"){
                
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            .bold()
            
            Button("About"){
                isDisplayingAbout = true
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            .bold()
            
            Button("Log Out"){
                isDisplayingLogin = true
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            .bold()
            
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
