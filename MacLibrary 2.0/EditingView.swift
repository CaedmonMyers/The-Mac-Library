//
//  EditingView.swift
//  App Library
//
//  Created by Caedmon Myers on 3/4/23.
//

import SwiftUI



struct EditingView: View {
    let fileManager = FileManager.default
    let path = "/Applications"
    @State var files: [String] = []
    
    @State var isOther: Bool
    
    @State var showAlert = false
    
    @State var buttonSize = CGFloat(15)
    
    @State var temporaryTitle = ""
    
    @State var selectedArray: Array<String>
    
    
    @State var utilities = defaults.array(forKey: "Utilities") as? Array<String> ?? ["/System/Applications/App Store.app", "/System/Applications/System Settings.app", "/Applications/Safari.app", "/System/Applications/Calculator.app", "/System/Applications/Home.app", "/System/Applications/Dictionary.app", "/System/Applications/Clock.app", "/System/Applications/TextEdit.app", "/System/Applications/Font Book.app", "/System/Applications/Mission Control.app", "/System/Applications/Utilities/Console.app", "/System/Applications/Utilities/VoiceOver Utility.app", "/System/Applications/Utilities/AirPort Utility.app", "/System/Applications/Utilities/Disk Utility.app", "/System/Applications/Utilities/Keychain Access.app", "/System/Applications/Utilities/Terminal.app", "/System/Applications/Utilities/Bluetooth File Exchange.app", "/System/Applications/Utilities/Audio MIDI Setup.app", "/System/Applications/Utilities/ColorSync Utility.app", "/System/Applications/Utilities/Screenshot.app", "/System/Applications/Automator.app", "/System/Applications/Utilities/System Information.app", "/System/Applications/Utilities/Migration Assistant.app", "/System/Applications/Utilities/Script Editor.app", "/System/Applications/Utilities/Digital Color Meter.app", "/System/Applications/Utilities/Activity Monitor.app", "/System/Applications/Time Machine.app", "/Applications/MacLibrary.app"]
    
    @State var entertainment = defaults.array(forKey: "Entertainment") as? Array<String> ?? ["/System/Applications/Music.app", "/System/Applications/TV.app", "/System/Applications/Podcasts.app"]
    
    @State var creativity = defaults.array(forKey: "Creativity") as? Array<String> ?? ["/System/Applications/Photos.app", "/System/Applications/Preview.app", "/System/Applications/Freeform.app"]
    
    @State var productivityAndFinance = defaults.array(forKey: "Productivity & Finance") as? Array<String> ?? ["/System/Applications/Shortcuts.app", "/System/Applications/Notes.app", "/System/Applications/Reminders.app", "/System/Applications/Calendar.app"]
    
    @State var social = defaults.array(forKey: "Social") as? Array<String> ?? ["/System/Applications/Messages.app", "/System/Applications/Mail.app", "/System/Applications/FaceTime.app", "/System/Applications/Contacts.app"]
    
    @State var infoAndReading = defaults.array(forKey: "Information & Reading") as? Array<String> ?? ["/System/Applications/Books.app", "/System/Applications/Weather.app", "/System/Applications/News.app", "/System/Applications/Stocks.app", "/System/Applications/Maps.app"]
    
    @State var education = defaults.array(forKey: "Education") as? Array<String> ?? ["", "", ""]
    
    @State var uncategorized = defaults.array(forKey: "Uncategorized") as? Array<String> ?? ["", "", ""]
    
    @State var games = defaults.array(forKey: "Games") as? Array<String> ?? ["/System/Applications/Chess.app", "", ""]
    
    @State var other = defaults.array(forKey: "Other") as? Array<String> ?? ["", "", ""]
    
    @State var neededCount = 3
    
    @State var selectedName: String
    
    var body: some View {
        VStack {
            ForEach(0..<selectedArray.count) { file in
                if URL(fileURLWithPath: selectedArray[file]).lastPathComponent != "Data" {
                    ZStack {
                        Color(NSColor.controlBackgroundColor)
                            .opacity(0.8)
                            .cornerRadius(20)
                        
                        LazyVGrid(columns: [GridItem()]) {
                            HStack {
                                Image(nsImage: getAppIcon(for: "\(selectedArray[file])", isAtPath: selectedName == "Utilities" ? false: selectedName == "Entertainment" ? false: selectedName == "Creativity" ? false: selectedName == "Productivity & Finance" ? false: selectedName == "Social" ? false: selectedName == "Information & Reading" ? false: selectedName == "Education" ? false: selectedName == "Games" ? false: selectedName == "Other" ? false: true))
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                
                                Text(URL(fileURLWithPath: selectedArray[file]).lastPathComponent)
                                
                                Spacer()
                                
                                Button {
                                    if isOther {
                                        //showAlert = true
                                    }
                                    else {
                                        if file != 0 {
                                            temporaryTitle = selectedArray[file - 1]
                                            
                                            selectedArray[file - 1] = selectedArray[file]
                                            
                                            selectedArray[file] = temporaryTitle
                                            
                                            defaults.set(selectedArray, forKey: selectedName)
                                        }
                                    }
                                } label: {
                                    Image(systemName: "arrowtriangle.up.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: buttonSize)
                                        .help("Move up in Category")
                                }.buttonStyle(.plain)
                                
                                Button {
                                    if isOther {
                                        //showAlert = true
                                    }
                                    else {
                                        if file != selectedArray.count - 1 {
                                            temporaryTitle = selectedArray[file + 1]
                                            
                                            selectedArray[file + 1] = selectedArray[file]
                                            
                                            selectedArray[file] = temporaryTitle
                                            
                                            defaults.set(selectedArray, forKey: selectedName)
                                        }
                                    }
                                } label: {
                                    Image(systemName: "arrowtriangle.down.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: buttonSize)
                                        .help("Move down in Category")
                                }.buttonStyle(.plain)
                            }.padding([.leading, .trailing], 20)
                            
                            HStack {
                                Button {
                                    if selectedName != "Utilities" {
                                        utilities.append(selectedName == "Other" ? "/Applications/\(selectedArray[file])": selectedArray[file])
                                        selectedArray.remove(at: file)
                                        defaults.set(selectedArray, forKey: selectedName)
                                        selectedArray.append("")
                                        if selectedArray.count < neededCount {
                                            defaults.set(selectedArray, forKey: selectedName)
                                        }
                                        defaults.set(utilities, forKey: "Utilities")
                                    }
                                } label: {
                                    Image(systemName: "wrench.and.screwdriver.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: buttonSize)
                                        .help("Move to Utilities")
                                }.buttonStyle(.plain)
                                
                                Button {
                                    if selectedName != "Entertainment" {
                                        entertainment.append(selectedName == "Other" ? "/Applications/\(selectedArray[file])": selectedArray[file])
                                        selectedArray.remove(at: file)
                                        defaults.set(selectedArray, forKey: selectedName)
                                        selectedArray.append("")
                                        if selectedArray.count < neededCount {
                                            defaults.set(selectedArray, forKey: selectedName)
                                        }
                                        defaults.set(entertainment, forKey: "Entertainment")
                                    }
                                } label: {
                                    Image(systemName: "theatermasks.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: buttonSize)
                                        .help("Move to Entertainment")
                                }.buttonStyle(.plain)
                                
                                Button {
                                    if selectedName != "Creativity" {
                                        creativity.append(selectedName == "Other" ? "/Applications/\(selectedArray[file])": selectedArray[file])
                                        selectedArray.remove(at: file)
                                        defaults.set(selectedArray, forKey: selectedName)
                                        selectedArray.append("")
                                        if selectedArray.count < neededCount {
                                            defaults.set(selectedArray, forKey: selectedName)
                                        }
                                        defaults.set(creativity, forKey: "Creativity")
                                    }
                                } label: {
                                    Image(systemName: "paintpalette.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: buttonSize)
                                        .help("Move to Creativity")
                                }.buttonStyle(.plain)
                                
                                Button {
                                    if selectedName != "Productivity & Finance" {
                                        productivityAndFinance.append(selectedName == "Other" ? "/Applications/\(selectedArray[file])": selectedArray[file])
                                        selectedArray.remove(at: file)
                                        defaults.set(selectedArray, forKey: selectedName)
                                        selectedArray.append("")
                                        if selectedArray.count < neededCount {
                                            defaults.set(selectedArray, forKey: selectedName)
                                        }
                                        defaults.set(productivityAndFinance, forKey: "Productivity & Finance")
                                    }
                                } label: {
                                    Image(systemName: "square.and.pencil")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: buttonSize)
                                        .help("Move to Productivity & Finance")
                                }.buttonStyle(.plain)
                                
                                Button {
                                    if selectedName != "Social" {
                                        social.append(selectedName == "Other" ? "/Applications/\(selectedArray[file])": selectedArray[file])
                                        selectedArray.remove(at: file)
                                        defaults.set(selectedArray, forKey: selectedName)
                                        selectedArray.append("")
                                        if selectedArray.count < neededCount {
                                            defaults.set(selectedArray, forKey: selectedName)
                                        }
                                        defaults.set(social, forKey: "Social")
                                    }
                                } label: {
                                    Image(systemName: "message.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: buttonSize)
                                        .help("Move to Social")
                                }.buttonStyle(.plain)
                                
                                Button {
                                    if selectedName != "Information & Reading" {
                                        infoAndReading.append(selectedName == "Other" ? "/Applications/\(selectedArray[file])": selectedArray[file])
                                        selectedArray.remove(at: file)
                                        defaults.set(selectedArray, forKey: selectedName)
                                        selectedArray.append("")
                                        if selectedArray.count < neededCount {
                                            defaults.set(selectedArray, forKey: selectedName)
                                        }
                                        defaults.set(infoAndReading, forKey: "Information & Reading")
                                    }
                                } label: {
                                    Image(systemName: "books.vertical.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: buttonSize)
                                        .help("Move to Information & Reading")
                                }.buttonStyle(.plain)
                                
                                Button {
                                    if selectedName != "Education" {
                                        education.append(selectedName == "Other" ? "/Applications/\(selectedArray[file])": selectedArray[file])
                                        selectedArray.remove(at: file)
                                        defaults.set(selectedArray, forKey: selectedName)
                                        selectedArray.append("")
                                        if selectedArray.count < neededCount {
                                            defaults.set(selectedArray, forKey: selectedName)
                                        }
                                        defaults.set(education, forKey: "Education")
                                    }
                                } label: {
                                    Image(systemName: "graduationcap.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: buttonSize)
                                        .help("Move to Education")
                                }.buttonStyle(.plain)
                                
                                Button {
                                    if selectedName != "Games" {
                                        games.append(selectedName == "Other" ? "/Applications/\(selectedArray[file])": selectedArray[file])
                                        selectedArray.remove(at: file)
                                        defaults.set(selectedArray, forKey: selectedName)
                                        selectedArray.append("")
                                        if selectedArray.count < neededCount {
                                            defaults.set(selectedArray, forKey: selectedName)
                                        }
                                        defaults.set(games, forKey: "Games")
                                    }
                                } label: {
                                    Image(systemName: "gamecontroller.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: buttonSize)
                                        .help("Move to Games")
                                }.buttonStyle(.plain)
                                
                                
                                
                                Button {
                                    if selectedName != "Other" {
                                        selectedArray.remove(at: selectedArray.firstIndex(of: selectedArray[file])!)
                                        defaults.set(selectedArray, forKey: selectedName)
                                        selectedArray.append("")
                                        if selectedArray.count < neededCount {
                                            defaults.set(selectedArray, forKey: selectedName)
                                        }
                                    }
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: buttonSize)
                                        .help("Move to Other")
                                }.buttonStyle(.plain)
                            }
                            
                            Spacer()
                                .frame(height: 10)
                        }
                    }.frame(width: 300, height: 110)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Unavailable"), message: Text("You cannot re-arrange this category."))
                        }
                }
            }
        }
        .onAppear() {
            if var files = defaults.array(forKey: "Utilities") as? [String] {
                print("Original array: \(files)")
                for index in files.indices {
                    let file = files[index]
                    if file == "Data" {
                        files.remove(at: index)
                        defaults.set(files, forKey: "Utilities")
                        print("Modified array: \(files)")
                        break
                    }
                }
            } else {
                print("Error: Failed to retrieve array from UserDefaults")
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        selectedArray.move(fromOffsets: source, toOffset: destination)
    }
    
    func getFiles() -> [String] {
        do {
            let files = try fileManager.contentsOfDirectory(atPath: path)
            return files.filter { $0.hasSuffix(".app") }
        } catch {
            print("Error getting files")
            return []
        }
    }
    
    func getAppIcon(for app: String, isAtPath: Bool) -> NSImage {
        if isAtPath {
            let url = URL(fileURLWithPath: "\(path)/\(app)")
            if let icon = NSWorkspace.shared.icon(forFile: url.path) as NSImage? {
                return icon
            }
            return NSImage()
        }
        else {
            let url = URL(fileURLWithPath: "\(app)")
            if let icon = NSWorkspace.shared.icon(forFile: url.path) as NSImage? {
                return icon
            }
            return NSImage()
        }
    }
}


