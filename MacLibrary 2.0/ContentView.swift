import SwiftUI


let defaults = UserDefaults.standard

class CategorySettings: ObservableObject {
    @Published var utilities = ["/System/Applications/App Store.app", "/System/Applications/System Settings.app", "/Applications/Safari.app", "/System/Applications/Calculator.app", "/System/Applications/Home.app", "/System/Applications/Dictionary.app", "/System/Applications/Clock.app", "/System/Applications/TextEdit.app", "/System/Applications/Font Book.app", "/System/Applications/Mission Control.app", "/System/Applications/Utilities/Console.app", "/System/Applications/Utilities/VoiceOver Utility.app", "/System/Applications/Utilities/AirPort Utility.app", "/System/Applications/Utilities/Disk Utility.app", "/System/Applications/Utilities/Keychain Access.app", "/System/Applications/Utilities/Terminal.app", "/System/Applications/Utilities/Bluetooth File Exchange.app", "/System/Applications/Utilities/Audio MIDI Setup.app", "/System/Applications/Utilities/ColorSync Utility.app", "/System/Applications/Utilities/Screenshot.app", "/System/Applications/Automator.app", "/System/Applications/Utilities/System Information.app", "/System/Applications/Utilities/Migration Assistant.app", "/System/Applications/Utilities/Script Editor.app", "/System/Applications/Utilities/Digital Color Meter.app", "/System/Applications/Utilities/Activity Monitor.app", "/System/Applications/Time Machine.app", "/Applications/App Library.app"] {
        didSet {
            defaults.setValue(utilities, forKey: "Utilities")
        }
    }
    
    @Published var entertainment = ["/System/Applications/Music.app", "/System/Applications/TV.app", "/System/Applications/Podcasts.app"] {
        didSet {
            defaults.setValue(entertainment, forKey: "Entertainment")
        }
    }
    
    @Published var creativity = ["/System/Applications/Photos.app", "/System/Applications/Preview.app", "/System/Applications/Freeform.app"] {
        didSet {
            defaults.setValue(creativity, forKey: "Creativity")
        }
    }
    
    @Published var productivityAndFinance = ["/System/Applications/Shortcuts.app", "/System/Applications/Notes.app", "/System/Applications/Reminders.app", "/System/Applications/Calendar.app"] {
        didSet {
            defaults.setValue(productivityAndFinance, forKey: "Productivity & Finance")
        }
    }
    
    @Published var social = ["/System/Applications/Messages.app", "/System/Applications/Mail.app", "/System/Applications/FaceTime.app", "/System/Applications/Contacts.app"] {
        didSet {
            defaults.setValue(social, forKey: "Social")
        }
    }
    
    @Published var infoAndReading = ["/System/Applications/Books.app", "/System/Applications/Weather.app", "/System/Applications/News.app", "/System/Applications/Stocks.app", "/System/Applications/Maps.app"] {
        didSet {
            defaults.setValue(infoAndReading, forKey: "Information & Reading")
        }
    }
    
    @Published var education = ["", "", ""] {
        didSet {
            defaults.setValue(education, forKey: "Education")
        }
    }
    
    @Published var games = ["/System/Applications/Photo Booth.app", "/System/Applications/VoiceMemos.app", "/System/Applications/QuickTime Player.app", "/System/Applications/Siri.app", "/System/Applications/Stickies.app"] {
        didSet {
            defaults.setValue(games, forKey: "Games")
        }
    }
    
    @Published var other = ["", "", ""] {
        didSet {
            defaults.setValue(other, forKey: "Other")
        }
    }
    
    @Published var uncategorized = ["", "", ""] {
        didSet {
            defaults.setValue(uncategorized, forKey: "Uncategorized")
        }
    }
}


struct ContentView: View {
    let fileManager = FileManager.default
    let path = "/Applications"
    let systemPath = "/System/Applications"
    let utilityPath = "/System/Applications/Utilities"
    @State var files: [String] = []
    @State var systemFiles: [String] = []
    @State var utilityFiles: [String] = []
    
    @State var categories = ["Utilities", "Entertainment", "Creativity", "Productivity & Finance", "Social", "Information & Reading", "Education", "Games", "Other"]
    
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
    
    
    @State var selectedArray = [""]
    
    @State var selectedName = ""
    
    @State var showExpanded = false
    @State var editingCategory = false
    
    @State var filteredFiles = [""]
    @State var filteredSystemFiles = [""]
    @State var filteredUtilityFiles = [""]
    
    @State var shortcutPath = ""
    @State var blankText = ""
    
    @State var selectedApp = 0
    
    @State var searchText = ""
    @State var focusedSearch = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    Spacer()
                        .frame(height: 25)
                    
                    HStack {
                        Text("MacLibrary")
                            .bold()
                            .font(.largeTitle)
                            .padding(10)
                        
                        Spacer()
                    }
                    
                    SearchBar(text: $searchText)
                    
                    Spacer()
                        .frame(height: 25)
                    
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach($categories, id:\.self) { category in
                            VStack {
                                ZStack {
                                    Color(category.wrappedValue != shortcutPath ? .white: .black)
                                        .opacity(0.8)
                                        .frame(width: 125, height: 125)
                                        .cornerRadius(20)
                                    
                                    
                                    LazyVGrid(columns: [GridItem(spacing: 10), GridItem(spacing: 10)]) {
                                        if category.wrappedValue == "Utilities" ? utilities.count > 0 ? utilities[0] != "" : false :
                                                category.wrappedValue == "Entertainment" ? entertainment.count > 0 ? entertainment[0] != "" : false :
                                                category.wrappedValue == "Creativity" ? creativity.count > 0 ? creativity[0] != "" : false :
                                                category.wrappedValue == "Productivity & Finance" ? productivityAndFinance.count > 0 ? productivityAndFinance[0] != "" : false :
                                                category.wrappedValue == "Social" ? social.count > 0 ? social[0] != "" : false :
                                                category.wrappedValue == "Information & Reading" ? infoAndReading.count > 0 ? infoAndReading[0] != "" : false :
                                                category.wrappedValue == "Education" ? education.count > 0 ? education[0] != "" : false :
                                                category.wrappedValue == "Games" ? games.count > 0 ? games[0] != "" : false :
                                                filteredFiles.count > 0 ? true : false {
                                            
                                            //category == "Uncategorized" ? uncategorized[0] != "":
                                            //"/Applications/\(filteredFiles[0])" != "" {
                                            Button {
                                                let url = URL(fileURLWithPath: "\(category.wrappedValue == "Utilities" ? utilities[0]: category.wrappedValue == "Entertainment" ? entertainment[0]: category.wrappedValue == "Creativity" ? creativity[0]: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance[0]: category.wrappedValue == "Social" ? social[0]: category.wrappedValue == "Information & Reading" ? infoAndReading[0]: category.wrappedValue == "Education" ? education[0]: category.wrappedValue == "Games" ? games[0]: category.wrappedValue == "Uncategorized" ? uncategorized[0]: "/Applications/\(filteredFiles[0])")")
                                                NSWorkspace.shared.open(url)
                                            } label: {
                                                Image(nsImage: getAppIcon(for: category.wrappedValue == "Utilities" ? utilities[0]: category.wrappedValue == "Entertainment" ? entertainment[0]: category.wrappedValue == "Creativity" ? creativity[0]: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance[0]: category.wrappedValue == "Social" ? social[0]: category.wrappedValue == "Information & Reading" ? infoAndReading[0]: category.wrappedValue == "Education" ? education[0]: category.wrappedValue == "Games" ? games[0]: category.wrappedValue == "Uncategorized" ? uncategorized[0]: "/Applications/\(filteredFiles[0])", isAtPath: false))
                                                    .resizable()
                                                    .frame(width: 55, height: 55)
                                                    .shadow(radius: 10)
                                            }.buttonStyle(.plain)
                                            
                                            
                                        }
                                        
                                        
                                        else {
                                            Image("shruggie")
                                                .resizable()
                                                .frame(width: 45, height: 45)
                                                .onTapGesture {
                                                    selectedArray = category.wrappedValue == "Utilities" ? utilities: category.wrappedValue == "Entertainment" ? entertainment: category.wrappedValue == "Creativity" ? creativity: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance: category.wrappedValue == "Social" ? social: category.wrappedValue == "Information & Reading" ? infoAndReading: category.wrappedValue == "Education" ? education: category.wrappedValue == "Games" ? games: category.wrappedValue == "Uncategorized" ? uncategorized: filteredFiles
                                                    
                                                    selectedName = category.wrappedValue
                                                    
                                                    showExpanded .toggle()
                                                }
                                                .shadow(radius: 10)
                                        }
                                        
                                        if category.wrappedValue == "Utilities" ? utilities.count > 1 ? utilities[1] != "" : false :
                                                category.wrappedValue == "Entertainment" ? entertainment.count > 1 ? entertainment[0] != "" : false :
                                                category.wrappedValue == "Creativity" ? creativity.count > 1 ? creativity[1] != "" : false :
                                                category.wrappedValue == "Productivity & Finance" ? productivityAndFinance.count > 1 ? productivityAndFinance[0] != "" : false :
                                                category.wrappedValue == "Social" ? social.count > 1 ? social[1] != "" : false :
                                                category.wrappedValue == "Information & Reading" ? infoAndReading.count > 1 ? infoAndReading[1] != "" : false :
                                                category.wrappedValue == "Education" ? education.count > 1 ? education[1] != "" : false :
                                                category.wrappedValue == "Games" ? games.count > 1 ? games[1] != "" : false :
                                                filteredFiles.count > 1 ? true : false {
                                            
                                            //category == "Uncategorized" ? uncategorized[0] != "":
                                            //"/Applications/\(filteredFiles[0])" != "" {
                                            Button {
                                                let url = URL(fileURLWithPath: "\(category.wrappedValue == "Utilities" ? utilities[1]: category.wrappedValue == "Entertainment" ? entertainment[1]: category.wrappedValue == "Creativity" ? creativity[1]: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance[1]: category.wrappedValue == "Social" ? social[1]: category.wrappedValue == "Information & Reading" ? infoAndReading[1]: category.wrappedValue == "Education" ? education[1]: category.wrappedValue == "Games" ? games[1]: category.wrappedValue == "Uncategorized" ? uncategorized[1]: "/Applications/\(filteredFiles[1])")")
                                                NSWorkspace.shared.open(url)
                                            } label: {
                                                Image(nsImage: getAppIcon(for: category.wrappedValue == "Utilities" ? utilities[1]: category.wrappedValue == "Entertainment" ? entertainment[1]: category.wrappedValue == "Creativity" ? creativity[1]: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance[1]: category.wrappedValue == "Social" ? social[1]: category.wrappedValue == "Information & Reading" ? infoAndReading[1]: category.wrappedValue == "Education" ? education[1]: category.wrappedValue == "Games" ? games[1]: category.wrappedValue == "Uncategorized" ? uncategorized[1]: "/Applications/\(filteredFiles[1])", isAtPath: false))
                                                    .resizable()
                                                    .frame(width: 55, height: 55)
                                                    .shadow(radius: 10)
                                            }.buttonStyle(.plain)
                                            
                                            
                                        }
                                        
                                        else {
                                            Image("shruggie")
                                                .resizable()
                                                .frame(width: 45, height: 45)
                                                .onTapGesture {
                                                    selectedArray = category.wrappedValue == "Utilities" ? utilities: category.wrappedValue == "Entertainment" ? entertainment: category.wrappedValue == "Creativity" ? creativity: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance: category.wrappedValue == "Social" ? social: category.wrappedValue == "Information & Reading" ? infoAndReading: category.wrappedValue == "Education" ? education: category.wrappedValue == "Games" ? games: category.wrappedValue == "Uncategorized" ? uncategorized: filteredFiles
                                                    
                                                    selectedName = category.wrappedValue
                                                    
                                                    showExpanded .toggle()
                                                }
                                                .shadow(radius: 10)
                                        }
                                        
                                        if category.wrappedValue == "Utilities" ? utilities.count > 2 ? utilities[2] != "" : false :
                                                category.wrappedValue == "Entertainment" ? entertainment.count > 2 ? entertainment[0] != "" : false :
                                                category.wrappedValue == "Creativity" ? creativity.count > 2 ? creativity[0] != "" : false :
                                                category.wrappedValue == "Productivity & Finance" ? productivityAndFinance.count > 2 ? productivityAndFinance[2] != "" : false :
                                                category.wrappedValue == "Social" ? social.count > 2 ? social[2] != "" : false :
                                                category.wrappedValue == "Information & Reading" ? infoAndReading.count > 2 ? infoAndReading[0] != "" : false :
                                                category.wrappedValue == "Education" ? education.count > 2 ? education[2] != "" : false :
                                                category.wrappedValue == "Games" ? games.count > 2 ? games[2] != "" : false :
                                                filteredFiles.count > 2 ? true : false {
                                            
                                            //category == "Uncategorized" ? uncategorized[0] != "":
                                            //"/Applications/\(filteredFiles[0])" != "" {
                                            Button {
                                                let url = URL(fileURLWithPath: "\(category.wrappedValue == "Utilities" ? utilities[2]: category.wrappedValue == "Entertainment" ? entertainment[2]: category.wrappedValue == "Creativity" ? creativity[2]: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance[2]: category.wrappedValue == "Social" ? social[2]: category.wrappedValue == "Information & Reading" ? infoAndReading[2]: category.wrappedValue == "Education" ? education[2]: category.wrappedValue == "Games" ? games[2]: category.wrappedValue == "Uncategorized" ? uncategorized[2]: "/Applications/\(filteredFiles[2])")")
                                                NSWorkspace.shared.open(url)
                                            } label: {
                                                Image(nsImage: getAppIcon(for: category.wrappedValue == "Utilities" ? utilities[2]: category.wrappedValue == "Entertainment" ? entertainment[2]: category.wrappedValue == "Creativity" ? creativity[2]: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance[2]: category.wrappedValue == "Social" ? social[2]: category.wrappedValue == "Information & Reading" ? infoAndReading[2]: category.wrappedValue == "Education" ? education[2]: category.wrappedValue == "Games" ? games[2]: category.wrappedValue == "Uncategorized" ? uncategorized[2]: "/Applications/\(filteredFiles[2])", isAtPath: false))
                                                    .resizable()
                                                    .frame(width: 55, height: 55)
                                                    .shadow(radius: 10)
                                            }.buttonStyle(.plain)
                                            
                                            
                                        }
                                        
                                        else {
                                            Image("shruggie")
                                                .resizable()
                                                .frame(width: 45, height: 45)
                                                .onTapGesture {
                                                    selectedArray = category.wrappedValue == "Utilities" ? utilities: category.wrappedValue == "Entertainment" ? entertainment: category.wrappedValue == "Creativity" ? creativity: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance: category.wrappedValue == "Social" ? social: category.wrappedValue == "Information & Reading" ? infoAndReading: category.wrappedValue == "Education" ? education: category.wrappedValue == "Games" ? games: category.wrappedValue == "Uncategorized" ? uncategorized: filteredFiles
                                                    
                                                    selectedName = category.wrappedValue
                                                    
                                                    showExpanded .toggle()
                                                }
                                                .shadow(radius: 10)
                                        }
                                        
                                        
                                        Image("applibrary.moreapps")
                                            .resizable()
                                            .frame(width: 45, height: 45)
                                            .onTapGesture {
                                                selectedArray = category.wrappedValue == "Utilities" ? utilities: category.wrappedValue == "Entertainment" ? entertainment: category.wrappedValue == "Creativity" ? creativity: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance: category.wrappedValue == "Social" ? social: category.wrappedValue == "Information & Reading" ? infoAndReading: category.wrappedValue == "Education" ? education: category.wrappedValue == "Games" ? games: category.wrappedValue == "Uncategorized" ? uncategorized: filteredFiles
                                                
                                                selectedName = category.wrappedValue
                                                
                                                showExpanded .toggle()
                                            }
                                            .shadow(radius: 10)
                                        
                                    }.frame(width: 100, height: 100)
                                }
                                .onAppear {
                                    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in
                                        if event.keyCode == 18 && event.modifierFlags.contains(.command) && category.wrappedValue == "Utilities" {
                                            shortcutPath = category.wrappedValue
                                            
                                            selectedArray = category.wrappedValue == "Utilities" ? utilities: category.wrappedValue == "Entertainment" ? entertainment: category.wrappedValue == "Creativity" ? creativity: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance: category.wrappedValue == "Social" ? social: category.wrappedValue == "Information & Reading" ? infoAndReading: category.wrappedValue == "Education" ? education: category.wrappedValue == "Games" ? games: category.wrappedValue == "Uncategorized" ? uncategorized: filteredFiles
                                            
                                            selectedName = category.wrappedValue
                                            
                                            print(category)
                                            print(shortcutPath)
                                        }
                                        return event
                                    }
                                    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in
                                        if event.keyCode == 19 && event.modifierFlags.contains(.command) && category.wrappedValue == "Entertainment" {
                                            shortcutPath = category.wrappedValue
                                            
                                            selectedArray = category.wrappedValue == "Utilities" ? utilities: category.wrappedValue == "Entertainment" ? entertainment: category.wrappedValue == "Creativity" ? creativity: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance: category.wrappedValue == "Social" ? social: category.wrappedValue == "Information & Reading" ? infoAndReading: category.wrappedValue == "Education" ? education: category.wrappedValue == "Games" ? games: category.wrappedValue == "Uncategorized" ? uncategorized: filteredFiles
                                            
                                            selectedName = category.wrappedValue
                                            
                                            print(category)
                                            print(shortcutPath)
                                        }
                                        return event
                                    }
                                    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in
                                        if event.keyCode == 20 && event.modifierFlags.contains(.command) && category.wrappedValue == "Creativity" {
                                            shortcutPath = category.wrappedValue
                                            
                                            selectedArray = category.wrappedValue == "Utilities" ? utilities: category.wrappedValue == "Entertainment" ? entertainment: category.wrappedValue == "Creativity" ? creativity: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance: category.wrappedValue == "Social" ? social: category.wrappedValue == "Information & Reading" ? infoAndReading: category.wrappedValue == "Education" ? education: category.wrappedValue == "Games" ? games: category.wrappedValue == "Uncategorized" ? uncategorized: filteredFiles
                                            
                                            selectedName = category.wrappedValue
                                            
                                            print(category)
                                            print(shortcutPath)
                                        }
                                        return event
                                    }
                                    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in
                                        if event.keyCode == 21 && event.modifierFlags.contains(.command) && category.wrappedValue == "Productivity & Finance" {
                                            shortcutPath = category.wrappedValue
                                            
                                            selectedArray = category.wrappedValue == "Utilities" ? utilities: category.wrappedValue == "Entertainment" ? entertainment: category.wrappedValue == "Creativity" ? creativity: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance: category.wrappedValue == "Social" ? social: category.wrappedValue == "Information & Reading" ? infoAndReading: category.wrappedValue == "Education" ? education: category.wrappedValue == "Games" ? games: category.wrappedValue == "Uncategorized" ? uncategorized: filteredFiles
                                            
                                            selectedName = category.wrappedValue
                                            
                                            print(category)
                                            print(shortcutPath)
                                        }
                                        return event
                                    }
                                    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in
                                        if event.keyCode == 23 && event.modifierFlags.contains(.command) && category.wrappedValue == "Social" {
                                            shortcutPath = category.wrappedValue
                                            
                                            selectedArray = category.wrappedValue == "Utilities" ? utilities: category.wrappedValue == "Entertainment" ? entertainment: category.wrappedValue == "Creativity" ? creativity: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance: category.wrappedValue == "Social" ? social: category.wrappedValue == "Information & Reading" ? infoAndReading: category.wrappedValue == "Education" ? education: category.wrappedValue == "Games" ? games: category.wrappedValue == "Uncategorized" ? uncategorized: filteredFiles
                                            
                                            selectedName = category.wrappedValue
                                            
                                            print(category)
                                            print(shortcutPath)
                                        }
                                        return event
                                    }
                                    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in
                                        if event.keyCode == 22 && event.modifierFlags.contains(.command) && category.wrappedValue == "Information & Reading" {
                                            shortcutPath = category.wrappedValue
                                            
                                            selectedArray = category.wrappedValue == "Utilities" ? utilities: category.wrappedValue == "Entertainment" ? entertainment: category.wrappedValue == "Creativity" ? creativity: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance: category.wrappedValue == "Social" ? social: category.wrappedValue == "Information & Reading" ? infoAndReading: category.wrappedValue == "Education" ? education: category.wrappedValue == "Games" ? games: category.wrappedValue == "Uncategorized" ? uncategorized: filteredFiles
                                            
                                            selectedName = category.wrappedValue
                                            
                                            print(category)
                                            print(shortcutPath)
                                        }
                                        return event
                                    }
                                    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in
                                        if event.keyCode == 26 && event.modifierFlags.contains(.command) && category.wrappedValue == "Education" {
                                            shortcutPath = category.wrappedValue
                                            
                                            selectedArray = category.wrappedValue == "Utilities" ? utilities: category.wrappedValue == "Entertainment" ? entertainment: category.wrappedValue == "Creativity" ? creativity: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance: category.wrappedValue == "Social" ? social: category.wrappedValue == "Information & Reading" ? infoAndReading: category.wrappedValue == "Education" ? education: category.wrappedValue == "Games" ? games: category.wrappedValue == "Uncategorized" ? uncategorized: filteredFiles
                                            
                                            selectedName = category.wrappedValue
                                            
                                            print(category)
                                            print(shortcutPath)
                                        }
                                        return event
                                    }
                                    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in
                                        if event.keyCode == 28 && event.modifierFlags.contains(.command) && category.wrappedValue == "Games" {
                                            shortcutPath = category.wrappedValue
                                            
                                            selectedArray = category.wrappedValue == "Utilities" ? utilities: category.wrappedValue == "Entertainment" ? entertainment: category.wrappedValue == "Creativity" ? creativity: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance: category.wrappedValue == "Social" ? social: category.wrappedValue == "Information & Reading" ? infoAndReading: category.wrappedValue == "Education" ? education: category.wrappedValue == "Games" ? games: category.wrappedValue == "Uncategorized" ? uncategorized: filteredFiles
                                            
                                            selectedName = category.wrappedValue
                                            
                                            print(category)
                                            print(shortcutPath)
                                        }
                                        return event
                                    }
                                    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in
                                        if event.keyCode == 25 && event.modifierFlags.contains(.command) && category.wrappedValue == "Other" {
                                            shortcutPath = category.wrappedValue
                                            
                                            selectedArray = category.wrappedValue == "Utilities" ? utilities: category.wrappedValue == "Entertainment" ? entertainment: category.wrappedValue == "Creativity" ? creativity: category.wrappedValue == "Productivity & Finance" ? productivityAndFinance: category.wrappedValue == "Social" ? social: category.wrappedValue == "Information & Reading" ? infoAndReading: category.wrappedValue == "Education" ? education: category.wrappedValue == "Games" ? games: category.wrappedValue == "Uncategorized" ? uncategorized: filteredFiles
                                            
                                            selectedName = category.wrappedValue
                                            
                                            print(category)
                                            print(shortcutPath)
                                        }
                                        return event
                                    }
                                }
                                
                                Text(category.wrappedValue)
                                
                                Spacer()
                                    .frame(height: 20)
                            }
                        }
                        
                        
                        /*Divider()
                         
                         LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
                         ForEach(files, id: \.self) { file in
                         VStack {
                         Image(nsImage: getAppIcon(for: file, isAtPath: true))
                         .resizable()
                         .frame(width: 50, height: 50)
                         .onTapGesture {
                         let url = URL(fileURLWithPath: "\(path)/\(file)")
                         NSWorkspace.shared.open(url)
                         }
                         .onDrag({
                         NSItemProvider(object: file as NSString)
                         })
                         Text((file as NSString).deletingPathExtension.prefix(10) + (file.count > 14 ? "..." : ""))
                         .lineLimit(1)
                         .frame(width: 200)
                         .multilineTextAlignment(.center)
                         }
                         }
                         .onMove(perform: move)
                         }
                         
                         NavigationLink {
                         ChangeOrder()
                         } label: {
                         Text("Edit")
                         }*/
                        
                    }
                }
                .frame(width: 350, height: 600)
                .onAppear {
                    shortcutPath = "Utilities"
                    
                    selectedArray = utilities
                    
                    selectedName = "Utilities"
                    
                    print(shortcutPath)
                    
                    files = getFiles()
                    
                    filteredFiles = files.filter { file in
                        !utilities.contains(file) &&
                        !entertainment.contains(file) &&
                        !creativity.contains(file) &&
                        !productivityAndFinance.contains(file) &&
                        !social.contains(file) &&
                        !infoAndReading.contains(file) &&
                        !education.contains(file) &&
                        !games.contains(file)
                        //!other.contains(file)
                    }
                    
                    systemFiles = getSystemFiles()
                    
                    filteredSystemFiles = systemFiles.filter { file in
                        !utilities.contains(file) &&
                        !entertainment.contains(file) &&
                        !creativity.contains(file) &&
                        !productivityAndFinance.contains(file) &&
                        !social.contains(file) &&
                        !infoAndReading.contains(file) &&
                        !education.contains(file) &&
                        !games.contains(file)
                        //!other.contains(file)
                    }
                    
                    utilityFiles = getUtilityFiles()
                    
                    filteredUtilityFiles = utilityFiles.filter { file in
                        !utilities.contains(file) &&
                        !entertainment.contains(file) &&
                        !creativity.contains(file) &&
                        !productivityAndFinance.contains(file) &&
                        !social.contains(file) &&
                        !infoAndReading.contains(file) &&
                        !education.contains(file) &&
                        !games.contains(file)
                        //!other.contains(file)
                    }
                }
                
                if showExpanded {
                    ScrollView {
                        Spacer()
                            .frame(height: 25)
                        
                        HStack {
                            Text(selectedName)
                                .bold()
                                .font(.largeTitle)
                                .padding(10)
                            
                            Spacer()
                            
                            
                            Button {
                                editingCategory.toggle()
                                
                                utilities = defaults.array(forKey: "Utilities") as? Array<String> ?? ["/System/Applications/App Store.app", "/System/Applications/System Settings.app", "/Applications/Safari.app", "/System/Applications/Calculator.app", "/System/Applications/Home.app", "/System/Applications/Dictionary.app", "/System/Applications/Clock.app", "/System/Applications/TextEdit.app", "/System/Applications/Font Book.app", "/System/Applications/Mission Control.app", "/System/Applications/Utilities/Console.app", "/System/Applications/Utilities/VoiceOver Utility.app", "/System/Applications/Utilities/AirPort Utility.app", "/System/Applications/Utilities/Disk Utility.app", "/System/Applications/Utilities/Keychain Access.app", "/System/Applications/Utilities/Terminal.app", "/System/Applications/Utilities/Bluetooth File Exchange.app", "/System/Applications/Utilities/Audio MIDI Setup.app", "/System/Applications/Utilities/ColorSync Utility.app", "/System/Applications/Utilities/Screenshot.app", "/System/Applications/Automator.app", "/System/Applications/Utilities/System Information.app", "/System/Applications/Utilities/Migration Assistant.app", "/System/Applications/Utilities/Script Editor.app", "/System/Applications/Utilities/Digital Color Meter.app", "/System/Applications/Utilities/Activity Monitor.app", "/System/Applications/Time Machine.app", "/Applications/App Library.app"]
                                
                                entertainment = defaults.array(forKey: "Entertainment") as? Array<String> ?? ["/System/Applications/Music.app", "/System/Applications/TV.app", "/System/Applications/Podcasts.app"]
                                
                                creativity = defaults.array(forKey: "Creativity") as? Array<String> ?? ["/System/Applications/Photos.app", "/System/Applications/Preview.app", "/System/Applications/Freeform.app"]
                                
                                productivityAndFinance = defaults.array(forKey: "Productivity & Finance") as? Array<String> ?? ["/System/Applications/Shortcuts.app", "/System/Applications/Notes.app", "/System/Applications/Reminders.app", "/System/Applications/Calendar.app"]
                                
                                social = defaults.array(forKey: "Social") as? Array<String> ?? ["/System/Applications/Messages.app", "/System/Applications/Mail.app", "/System/Applications/FaceTime.app", "/System/Applications/Contacts.app"]
                                
                                infoAndReading = defaults.array(forKey: "Information & Reading") as? Array<String> ?? ["/System/Applications/Books.app", "/System/Applications/Weather.app", "/System/Applications/News.app", "/System/Applications/Stocks.app", "/System/Applications/Maps.app"]
                                
                                education = defaults.array(forKey: "Education") as? Array<String> ?? ["", "", ""]
                                
                                uncategorized = defaults.array(forKey: "Uncategorized") as? Array<String> ?? ["", "", ""]
                                
                                games = defaults.array(forKey: "Games") as? Array<String> ?? ["/System/Applications/Chess.app", "", ""]
                                
                                other = defaults.array(forKey: "Other") as? Array<String> ?? ["/System/Applications/Photo Booth.app", "/System/Applications/VoiceMemos.app", "/System/Applications/QuickTime Player.app", "/System/Applications/Siri.app", "/System/Applications/Stickies.app"]
                            } label: {
                                ZStack {
                                    Color(NSColor.controlBackgroundColor)
                                        .cornerRadius(100)
                                        .frame(width: 75, height: 25)
                                    
                                    Text(editingCategory ? "Cancel": "Edit")
                                    
                                }.padding(10)
                            }.buttonStyle(.plain)
                        }
                        
                        Spacer()
                            .frame(height: 25)
                        
                        // The editable list here.
                        // It should re-arrange the selectedArray array
                        
                        if editingCategory {
                            EditingView(isOther: selectedName == "Uncategorized" ? true: false, selectedArray: selectedArray, selectedName: selectedName)
                        }
                        
                        
                        else {
                            LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
                                ForEach(selectedArray, id: \.self) { file in
                                    if file.replacingOccurrences(of: "System/", with: "").replacingOccurrences(of: "Applications/", with: "").replacingOccurrences(of: "Utilities/", with: "").dropLast(4) != "" {
                                        VStack {
                                            Image(nsImage: getAppIcon(for: "\(file)", isAtPath: selectedName == "Utilities" ? false: selectedName == "Entertainment" ? false: selectedName == "Creativity" ? false: selectedName == "Productivity & Finance" ? false: selectedName == "Social" ? false: selectedName == "Information & Reading" ? false: selectedName == "Education" ? false: selectedName == "Games" ? false: selectedName == "Uncategorized" ? false: true))
                                                .resizable()
                                                .frame(width: 64, height: 64)
                                                .onTapGesture {
                                                    let url = URL(fileURLWithPath: selectedName == "Utilities" ? file: selectedName == "Entertainment" ? file: selectedName == "Creativity" ? file: selectedName == "Productivity & Finance" ? file: selectedName == "Social" ? file: selectedName == "Information & Reading" ? file: selectedName == "Education" ? file: selectedName == "Games" ? file: selectedName == "Uncategorized" ? file: "/Applications/\(file)")
                                                    NSWorkspace.shared.open(url)
                                                }
                                            
                                            Text(URL(fileURLWithPath: file).lastPathComponent
                                                .replacingOccurrences(of: "/Applications/", with: "")
                                                .replacingOccurrences(of: "System/", with: "")
                                                .replacingOccurrences(of: "Utilities/", with: "")
                                                .dropLast(4)
                                                .prefix(10) + (file.replacingOccurrences(of: "System/", with: "").replacingOccurrences(of: "Applications/", with: "").replacingOccurrences(of: "Utilities/", with: "").dropLast(4).count > 15 ? "..." : ""))
                                            .lineLimit(1)
                                            .font(.caption)
                                            .font(Font.body.weight(.bold))
                                            .frame(width: 200)
                                            .multilineTextAlignment(.center)
                                            
                                        }
                                    }
                                }
                                
                                /*if selectedName == "Other" {
                                    ForEach(systemFiles, id: \.self) { file in
                                        if file.replacingOccurrences(of: "System/", with: "").replacingOccurrences(of: "Applications/", with: "").replacingOccurrences(of: "Utilities/", with: "").dropLast(4) != "" {
                                            VStack {
                                                Image(nsImage: getAppIcon(for: "\(file)", false)
                                                    .resizable()
                                                    .frame(width: 64, height: 64)
                                                    .onTapGesture {
                                                        let url = URL(fileURLWithPath: selectedName == "Utilities" ? file: selectedName == "Entertainment" ? file: selectedName == "Creativity" ? file: selectedName == "Productivity & Finance" ? file: selectedName == "Social" ? file: selectedName == "Information & Reading" ? file: selectedName == "Education" ? file: selectedName == "Games" ? file: selectedName == "Uncategorized" ? file: "/Applications/\(file)")
                                                        NSWorkspace.shared.open(url)
                                                    }
                                                
                                                Text(URL(fileURLWithPath: file).lastPathComponent
                                                    .replacingOccurrences(of: "/Applications/", with: "")
                                                    .replacingOccurrences(of: "System/", with: "")
                                                    .replacingOccurrences(of: "Utilities/", with: "")
                                                    .dropLast(4)
                                                    .prefix(10) + (file.replacingOccurrences(of: "System/", with: "").replacingOccurrences(of: "Applications/", with: "").replacingOccurrences(of: "Utilities/", with: "").dropLast(4).count > 15 ? "..." : ""))
                                                .lineLimit(1)
                                                .font(.caption)
                                                .font(Font.body.weight(.bold))
                                                .frame(width: 200)
                                                .multilineTextAlignment(.center)
                                                
                                            }
                                        }
                                    }
                                }*/
                            }
                        }
                    }.background(.ultraThinMaterial)
                        .onTapGesture {
                            showExpanded = false
                            editingCategory = false
                        }
                }
            }
        }.background(.ultraThinMaterial).frame(width: 350, height: 600)
            .onAppear() {
                NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) -> NSEvent? in
                    if event.keyCode == 36 {
                        showExpanded.toggle()
                        selectedApp = 0
                        print(event)
                    }
                    return event
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
            print("Error getting app files")
            return []
        }
    }
    
    func getSystemFiles() -> [String] {
        do {
            let files = try fileManager.contentsOfDirectory(atPath: systemPath)
            return files.filter { $0.hasSuffix(".app") }
        } catch {
            print("Error getting system app files")
            return []
        }
    }
    
    func getUtilityFiles() -> [String] {
        do {
            let files = try fileManager.contentsOfDirectory(atPath: utilityPath)
            return files.filter { $0.hasSuffix(".app") }
        } catch {
            print("Error getting utility app files")
            return []
        }
    }
    
    func getSystemIcon(for app: String, isUtility: Bool) -> NSImage {
        if isUtility {
            let url = URL(fileURLWithPath: "\(utilityPath)/\(app)")
            if let icon = NSWorkspace.shared.icon(forFile: url.path) as NSImage? {
                return icon
            }
            return NSImage()
        }
        else {
            let url = URL(fileURLWithPath: "\(systemPath)/\(app)")
            if let icon = NSWorkspace.shared.icon(forFile: url.path) as NSImage? {
                return icon
            }
            return NSImage()
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

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.body)
            
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle")
            }
        }
        .padding(8)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}


/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
