import SwiftUI
import Firebase
import FirebaseAnalytics


let WIDTH: CGFloat = 300
let HEIGTH: CGFloat = 600

@main
struct MacLibrary_2_0App: App {
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
    
    init() {
        // For Firebase
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification), perform: { _ in
                    NSApp.mainWindow?.standardWindowButton(.zoomButton)?.isHidden = true
                    NSApp.mainWindow?.standardWindowButton(.closeButton)?.isHidden = true
                    NSApp.mainWindow?.standardWindowButton(.miniaturizeButton)?.isHidden = true
                })
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willResignActiveNotification)) { _ in
                    var categoryList = [utilities, entertainment, creativity, productivityAndFinance, social, infoAndReading, education, games]
                    let categoryKeys = ["Utilities", "Entertainment", "Creativity", "Productivity & Finance", "Social", "Information & Reading", "Education", "Games"]
                    for i in 0..<categoryList.count {
                        let key = categoryKeys[i]
                        let category = categoryList[i].filter { $0 != "" }
                        defaults.set(category, forKey: key)
                    }
                    
                    NSApp.terminate(nil)
                }
                .onAppear {
                    guard let window = NSApp.mainWindow else { return }
                    window.setFrame(NSRect(x: 100, y: 0, width: 1200, height: 800), display: true)
                }
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle())
        .windowStyle(HiddenTitleBarWindowStyle())
        .defaultPosition(UnitPoint(x: 0.25, y: 0.5))
        .windowResizability(.contentSize)
        .commandsRemoved()
        .commands {
            CustomMenu()
        }
    }
}


struct CustomMenu: Commands {
    @State var settingsIsOpen = false
    @State var aboutIsOpen = false
    
    var body: some Commands {
        CommandGroup(replacing: .appSettings) {
            Button("Settings", action: {
                if !settingsIsOpen {
                    Settings().onDisappear() {
                        settingsIsOpen = false
                    }.openNewWindow(with: "Settings")
                    settingsIsOpen = true
                }
            }).keyboardShortcut(KeyboardShortcut(",", modifiers: .command))
            
            Button("About", action: {
                if !aboutIsOpen {
                    About().onDisappear() {
                        aboutIsOpen = false
                    }.openNewWindow(with: "About")
                    aboutIsOpen = true
                }
            }).keyboardShortcut(KeyboardShortcut("i", modifiers: .command))
        }
        CommandMenu("Search") {
            Button("All Apps", action: {
                
            }).keyboardShortcut(KeyboardShortcut("f", modifiers: .command))
        }
        CommandMenu("Help") {
            Button("Hot Corners", action: {
                
            })
        }
    }
}

extension View {
    private func newWindowInternal(with title: String) -> NSWindow {
        let window = NSWindow(
            contentRect: NSRect(x: 20, y: 20, width: 680, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false)
        window.center()
        window.isReleasedWhenClosed = false
        window.title = title
        window.makeKeyAndOrderFront(nil)
        return window
    }
    
    func openNewWindow(with title: String = "new Window") {
        self.newWindowInternal(with: title).contentView = NSHostingView(rootView: self)
    }
}
