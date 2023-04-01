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
    @Binding var project: Project
    @State var refresh: Bool = false
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    
                    TextField("Project Name", text: $project.project )
                        .placeholder(when: project.project.isEmpty) {
                        }
                        .padding()
                        .foregroundColor(Color(uiColor: .label))
                        .font(.headline)
                        .background(Color("textFieldBackgroundcolor")
                        .cornerRadius(10))
                    
                    TextField("Manufacture / Company", text: $project.manufacture)
                        .placeholder(when: project.project.isEmpty) {
                        }
                        .padding()
                        .foregroundColor(Color(uiColor: .label))
                        .font(.headline)
                        .background(Color("textFieldBackgroundcolor")
                        .cornerRadius(10))
                    
                    TextField("Location", text:  $project.address)
                        .placeholder(when: project.project.isEmpty) {
                        }
                        .padding()
                        .foregroundColor(Color(uiColor: .label))
                        .font(.headline)
                        .background(Color("textFieldBackgroundcolor")
                        .cornerRadius(10))
                    
                    TextField("Due Date", text: $project.due)
                        .placeholder(when: project.project.isEmpty) {
                        }
                        .padding()
                        .foregroundColor(Color(uiColor: .label))
                        .font(.headline)
                        .background(Color("textFieldBackgroundcolor")
                        .cornerRadius(10))
                    
                    Text("Description")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .frame(maxWidth: 300, minHeight: 40)
//                        .background(LinearGradient(colors: [.black,.pink],
//                                                   startPoint: .leading, endPoint: .trailing))
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

            }
            
            
            .navigationTitle(isNewProject ? "New Project" : "Edit Project")
            .background {
                Image("newproject2background")
            }
            
        }
        
    }
    func update() {
       refresh.toggle()
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
//    @State var project = Project()
    static var previews: some View {
        ProjectFormView(isNewProject: true, project: .constant(Project()))
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
