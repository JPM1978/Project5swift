//
//  Project .swift
//  Assist Pro Manager
//
//  Created by Jean on 3/31/23.
//

import Foundation


/// Represents model object for this app
struct Project: Codable, Identifiable {
    
    /// Unique Identifier for project
    var id: Int = UUID().hashValue
    
    /// The name of the project
    var project: String = ""
    
    /// The Name of the manufacture  of this  project
    var manufacture: String = ""
    
    /// Location of where Project is being constructed / worked / completed
    var address: String = ""
    
    /// Projects end date to complete said project
    var due: String = ""
    
    /// Description of project
    var details: String = ""
    
    
    
    
    /// This is an example medthod used for previews (shown on side of view)
    /// - Returns: Returns a placeholder project with place holder data
    static func example() -> Project {
        return Project(id: 100, project: "Project", manufacture: "Name of Company", address: "Location", due: "date to finish", details: "explanaition")
    }
}


