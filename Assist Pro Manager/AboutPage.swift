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
            
            Text( "This app is used to keep projects up to date mobility wise. Assisting in reminding projects of the basics of a project and navigate deadlines. We hope you find this app helpful and  we were happy to create it. Please feel free to contact us with any issues. @sanctuarygames30@gmail.com ")
                .padding()
            
            Text("(917)-271-7853")
//                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutPage()
    }
}
