//
//  About.swift
//  MacLibrary
//
//  Created by Caedmon Myers on 3/11/23.
//

import SwiftUI


extension Bundle {
    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }
}


struct About: View {
    var body: some View {
        VStack {
            Text("About")
                .bold()
                .font(.title)
            
            Text("\(Bundle.main.versionNumber)")
                .bold()
                .font(.title3)
            
            Text("\(Bundle.main.buildNumber)")
                .font(.caption)
            
            Image("MacLibrary Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
        }.padding().padding([.leading, .trailing], 20)
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
