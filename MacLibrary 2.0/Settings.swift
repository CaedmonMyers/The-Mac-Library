//
//  Settings.swift
//  MacLibrary 2.0
//
//  Created by Caedmon Myers on 3/11/23.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        TabView {
            General().tabItem {
                Label("General", systemImage: "gear")
            }
            Advanced().tabItem {
                Label("Advanced", systemImage: "wrench.and.screwdriver")
            }
            DangerZone().tabItem {
                Label("Danger Zone", systemImage: "exclamationmark.triangle")
            }
        }
    }
}



struct General: View {
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Group {
                        Text("Expanded view shows as...")
                            .font(.title)
                            .bold()
                        
                        HStack {
                            Button {
                                //
                            } label: {
                                VStack {
                                    Text("Compact")
                                }
                            }
                            
                            Button {
                                //
                            } label: {
                                VStack {
                                    Text("Expanded")
                                }
                            }
                            
                        }
                    }
                    
                    Group {
                        Text("Updates")
                            .font(.title)
                            .bold()
                        
                        NavigationLink {
                            //UpdaterView()
                        } label: {
                            Text("Check for Updates!")
                        }
                        
                    }
                }
            }
        }
    }
}

struct Advanced: View {
    var body: some View {
        VStack {
            Text("Advanced")
        }
    }
}

struct DangerZone: View {
    @State var deleteSlider = 0.0
    var body: some View {
        VStack {
            Slider(value: $deleteSlider, in: 0...100)
                .onChange(of: deleteSlider, perform: { value in
                    if value < 100 {
                        //deleteSlider = 0.0
                    }
                })
            Text(deleteSlider < 10 ? "Slide to delete" : deleteSlider < 20 ? "Deleting." : deleteSlider < 40 ? "Deleting.." : deleteSlider < 60 ? "Deleting..." : deleteSlider < 80 ? "Deleting...." : deleteSlider < 90 ? "Deleting....." : "Deleting......")

            
            Text("Slider Value: \(deleteSlider, specifier: "%.2f")")
        }
    }
}



struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}


