//
//  DetailView.swift
//  Assist Pro Manager
//
//  Created by Jean on 3/14/23.
//

import SwiftUI

struct DetailView: View {
    @State var sheetIsPresented = false
    var project: Project
    var body: some View {
        NavigationView{
            
            VStack{
                
                Text(project.project)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                    .padding()
                
                Text(project.address)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text(project.manufacture)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text(project.due)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text(project.details)
                    .padding()
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.orange)}
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    sheetIsPresented = true
                    print("Edit button pressed")
                } label: {
                    Text("Edit")
                }

            }
        }
        .sheet(isPresented: $sheetIsPresented) {
            ProjectFormView(isNewProject: false, project: project)
        }
        
    }
    
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(project: Project.example())
    }
}
