import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/riipen/Desktop/xcode/MeetingDND/MeetingDND/views/AppDelegate.swift", line: 1)
import Cocoa
import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: __designTimeInteger("#1472_0", fallback: 12)) {
            if let appIcon = NSApp.applicationIconImage {
                            Image(nsImage: appIcon)
                                .resizable()
                                .frame(width: __designTimeInteger("#1472_1", fallback: 64), height: __designTimeInteger("#1472_2", fallback: 64))
                                .cornerRadius(__designTimeInteger("#1472_3", fallback: 12))
                                .shadow(radius: __designTimeInteger("#1472_4", fallback: 3))
                                .padding(.top, __designTimeInteger("#1472_5", fallback: 10))
                        }
            Text(__designTimeString("#1472_6", fallback: "MeetingDND"))
                .font(.title)
                .bold()
            Text(__designTimeString("#1472_7", fallback: "Version 1.0"))
                .font(.subheadline)
            
            Spacer()

            VStack(spacing: __designTimeInteger("#1472_8", fallback: 4)) {
                Text(__designTimeString("#1472_9", fallback: "MeetingDND automatically manages Do Not Disturb & apps you choose when you join or leave Zoom meetings, helping you stay focused without interruptions."))
            }
            .font(.system(size: __designTimeInteger("#1472_10", fallback: 12)))

            Spacer()

            VStack(spacing: __designTimeInteger("#1472_11", fallback: 4)) {
                Text(__designTimeString("#1472_12", fallback: "This app is open source under the MIT License."))
                Link(__designTimeString("#1472_13", fallback: "View source on GitHub"), destination: URL(string: __designTimeString("#1472_14", fallback: "https://github.com/chris-snapops/meetingdnd"))!)
            }
            .font(.system(size: __designTimeInteger("#1472_15", fallback: 11)))
            .multilineTextAlignment(.center)

            Spacer()

            Text(__designTimeString("#1472_16", fallback: "Created by Chris Becher"))
                .font(.footnote)
                .foregroundColor(.secondary)

            Text(__designTimeString("#1472_17", fallback: "© 2025 SnapOps Inc. All rights reserved."))
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(width: __designTimeInteger("#1472_18", fallback: 200), height: __designTimeInteger("#1472_19", fallback: 300))
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var window: NSWindow!
    var aboutWindow: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the menu bar icon
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: __designTimeString("#1472_20", fallback: "equal"), accessibilityDescription: __designTimeString("#1472_21", fallback: "MeetingDND Icon"))
        }

        let titleItem = NSMenuItem()
        titleItem.action = #selector(showMainWindow)
        titleItem.attributedTitle = NSAttributedString(
            string: __designTimeString("#1472_22", fallback: "MeetingDND"),
            attributes: [.font: NSFont.boldSystemFont(ofSize: __designTimeInteger("#1472_23", fallback: 13))]
        )

        let menu = NSMenu()
        menu.addItem(titleItem)
        menu.addItem(.separator())
        menu.addItem(NSMenuItem(title: __designTimeString("#1472_24", fallback: "About"), action: #selector(showAboutWindow), keyEquivalent: __designTimeString("#1472_25", fallback: "")))
        menu.addItem(.separator())
        menu.addItem(NSMenuItem(title: __designTimeString("#1472_26", fallback: "Quit"), action: #selector(quitApp), keyEquivalent: __designTimeString("#1472_27", fallback: "q")))

        statusItem.menu = menu

        // Main window
        window = NSWindow(
            contentRect: NSRect(x: __designTimeInteger("#1472_28", fallback: 0), y: __designTimeInteger("#1472_29", fallback: 0), width: __designTimeInteger("#1472_30", fallback: 500), height: __designTimeInteger("#1472_31", fallback: 220)),
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: __designTimeBoolean("#1472_32", fallback: false)
        )
        window.center()
        window.isReleasedWhenClosed = __designTimeBoolean("#1472_33", fallback: false)
        window.title = __designTimeString("#1472_34", fallback: "MeetingDND")
        window.contentView = NSHostingView(rootView: ContentView())

        showMainWindow()
    }

    @objc func showMainWindow() {
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: __designTimeBoolean("#1472_35", fallback: true))
    }

    @objc func showAboutWindow() {
        if aboutWindow == nil {
            aboutWindow = NSWindow(
                contentRect: NSRect(x: __designTimeInteger("#1472_36", fallback: 0), y: __designTimeInteger("#1472_37", fallback: 0), width: __designTimeInteger("#1472_38", fallback: 420), height: __designTimeInteger("#1472_39", fallback: 250)),
                styleMask: [.titled, .closable],
                backing: .buffered,
                defer: __designTimeBoolean("#1472_40", fallback: false)
            )
            aboutWindow?.center()
            aboutWindow?.isReleasedWhenClosed = __designTimeBoolean("#1472_41", fallback: false)
            aboutWindow?.title = __designTimeString("#1472_42", fallback: "About Meetings DND")
            aboutWindow?.contentView = NSHostingView(rootView: AboutView())
        }

        aboutWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: __designTimeBoolean("#1472_43", fallback: true))
    }

    @objc func quitApp() {
        NSApp.terminate(nil)
    }
}

#Preview {
    AboutView()
}
