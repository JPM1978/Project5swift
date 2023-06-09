//
//  AboutPage.swift
//  Assist Pro Manager
//
//  Created by Jean on 3/21/23.
//

import SwiftUI

struct AboutPage: View {
    
    var body: some View {
        
        VStack {
            Text("Assist Pro Manager")
                .underline()
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.largeTitle)
                .multilineTextAlignment(.leading)
                .padding()
            
            Text( "This program was created using the following: Django, Swift, SwiftUI, KeychainAcces, Xcode, VScode, Bit.io, Render.com, github, Postman, Knox, and Corsheaders. ")
                .padding()
            
            Text( "This app is used to keep projects up to date mobility wise. Assisting in reminding projects of the basics of a project and navigate deadlines. We hope you find this app helpful and  we were happy to create it. Please feel free to contact us with any issues. ")
                .padding()
            
            Text("@sanctuarygames30@gmail.com")
                .foregroundColor(.white)
                .frame(maxWidth: 300, minHeight: 40)
                .background(LinearGradient(colors: [.yellow,.pink],
                                           startPoint: .leading, endPoint: .trailing))
                .clipShape(Capsule())
                .padding()
            
            Text("(917)-271-7853")
            
        }

    }
    
}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutPage()
    }
}
