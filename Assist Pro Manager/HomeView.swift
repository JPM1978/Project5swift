//
//  HomeView.swift
//  Assist Pro Manager
//
//  Created by Jean on 3/14/23.
//

import SwiftUI


struct Project: Codable, Identifiable {
    
    var id: Int = UUID().hashValue
    var project: String = ""
    var manufacture: String = ""
    var address: String = ""
    var due: String = ""
    var details: String = ""
    
    
    
    
    static func example() -> Project {
        return Project(id: 100, project: "Project", manufacture: "Name of Company", address: "Location", due: "date to finish", details: "explanaition")
    }
}


struct HomeView: View {
    @State var refresh: Bool = false
    @State var isDisplayingNewProject: Bool = false
    @State var projects: [Project] = []
    @State var isDisplayingLogin: Bool = false
    @State var isDisplayingManager: Bool = false
    @KeychainStorage("MyToken") var saveToken: String?
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(projects) { project in
                    NavigationLink {
                        DetailView(project: project)
                        
                    } label: {
                        VStack(alignment: .leading) {
                            Text(project.project)
                            Text(project.due)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                        }
                        .navigationTitle("Projects")
//                        .navigationBarTitleDisplayMode(.inline)
                        .foregroundColor(.primary)
                        
                    }
                    
                }
                .onDelete { indexSet in
                    let index = indexSet[indexSet.startIndex]
                    let projectToDelete = projects[index]
                    Task {
                        await delete(project: projectToDelete)
                    }
                    
                    
                    
                }
            }
            .background {
                Image("bikebackground")
            }
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isDisplayingManager = true
                    } label: {
                        Image(systemName: "list.bullet.circle")
                            .font(Font.title.weight(.bold))
                            .foregroundColor(.primary)
                        
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isDisplayingNewProject = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(Font.title.weight(.bold))
                            .foregroundColor(.primary)
                        
                    }}
                
            }
        }
        .onAppear {
            isDisplayingLogin = saveToken == nil
        }
        .sheet(isPresented: $isDisplayingNewProject) {
            ProjectFormView(isNewProject: true, project: Project())
        }
        .fullScreenCover(isPresented: $isDisplayingLogin) {
            LoginView()
        }
        .sheet(isPresented: $isDisplayingManager) {
            ManagerView()
        }
        
        
        .task {
            await fetchData()
        }
        .refreshable {
            await fetchData()
        }
        
    }
    func delete(project:Project) async {
        guard let encodedProject = try? JSONEncoder().encode(project) else { return }
        let prefixUrl = "https://project-5-mlyi.onrender.com"
        guard let url = URL(string: "\(prefixUrl)/assists/\(String(project.id))/") else {
            print("Not found url")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
        print(project)
        print(request.url)
    
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedProject)
            print(String(data: data, encoding: .utf8))
            print("success")
        } catch {
            print(error)
            print("failed")
        }
    }
    
    
    func fetchData() async {
        let url = URL(string: "https://project-5-mlyi.onrender.com/assists/?format=json")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            DispatchQueue.main.async {
                let projects = try! JSONDecoder().decode([Project].self, from: data)
                self.projects = projects
                
            }
        } catch {
            print(error)
        }
        
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
