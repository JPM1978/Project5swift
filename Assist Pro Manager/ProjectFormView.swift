//
//  ProjectFormView.swift
//  Assist Pro Manager
//
//  Created by Jean on 3/16/23.
//



import SwiftUI

struct ProjectFormView: View {
    var isNewProject: Bool
    @Environment(\.presentationMode) var presentationMode
    @State var project: Project
//    @State var function: fetchData
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    
                    TextField("", text: $project.project )
                        .placeholder(when: project.project.isEmpty) {
                            Text("Project Name").foregroundColor(.gray)
                        }
                        .padding()
                        .foregroundColor(Color(uiColor: .label))
                        .font(.headline)
                        .background(Color("textFieldBackgroundcolor")
                        .cornerRadius(10))
                    
                    TextField("", text: $project.manufacture)
                        .placeholder(when: project.project.isEmpty) {
                            Text("Manufacture/Company").foregroundColor(.gray)
                        }
                        .padding()
                        .foregroundColor(Color(uiColor: .label))
                        .font(.headline)
                        .background(Color("textFieldBackgroundcolor")
                        .cornerRadius(10))
                    
                    TextField("", text:  $project.address)
                        .placeholder(when: project.project.isEmpty) {
                            Text("Location").foregroundColor(.gray)
                        }
                        .padding()
                        .foregroundColor(Color(uiColor: .label))
                        .font(.headline)
                        .background(Color("textFieldBackgroundcolor")
                        .cornerRadius(10))
                    
                    TextField("", text: $project.due)
                        .placeholder(when: project.project.isEmpty) {
                            Text("Due Date").foregroundColor(.gray)
                        }
                        .padding()
                        .foregroundColor(Color(uiColor: .label))
                        .font(.headline)
                        .background(Color("textFieldBackgroundcolor")
                        .cornerRadius(10))
                    
                    Text("Description")
                        .foregroundColor(.white)
                        .frame(maxWidth: 300, minHeight: 40)
                        .background(LinearGradient(colors: [.black,.pink],
                                                   startPoint: .leading, endPoint: .trailing))
                        .clipShape(Capsule())
                    
                    TextEditor(text: $project.details)
                        .foregroundColor(Color(uiColor: .label))
                        .font(.headline)
                        .frame(minHeight: 200)
                        .background(Color.white)
                        .cornerRadius((10))
                        .padding(.bottom)
                        
                    
                    Button(action: {
                        Task {
                            await update(project: project)
                        }
                        
                        
                        
                    }, label:  {
                        Text(isNewProject ? "Add New Project" : "Update Project")
                                             
                    }
                    )
                    .buttonStyle(.borderedProminent)
                  
                    
                    .disabled(project.project.isEmpty || project.manufacture.isEmpty || project.address.isEmpty || project.due.isEmpty || project.details.isEmpty)
                    
                    Spacer()
                    
                }
                .padding()
            }
            
            
            .navigationTitle(isNewProject ? "New Project" : "Edit Project")
            .background {
                Image("newproject2background")
            }
            
        }
        
    }
    func update(project: Project) async {
        
        guard let encodedProject = try? JSONEncoder().encode(project) else { return }
        var url: URL
        if isNewProject {
            url = URL(string: "https://project-5-mlyi.onrender.com/assists/")!
        } else {
            url = URL(string: "https://project-5-mlyi.onrender.com/assists/\(project.id)")!
        }
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = isNewProject ? "POST" : "PUT"
        
        
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedProject)
            print(String(data: data, encoding: .utf8))
            presentationMode.wrappedValue.dismiss()
            
            
            
        } catch {
            print(error)
        }
    }
}

struct NewProjectView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectFormView(isNewProject: true, project: Project())
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
