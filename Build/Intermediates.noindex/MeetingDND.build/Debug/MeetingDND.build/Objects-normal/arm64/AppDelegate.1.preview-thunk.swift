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
            Text(__designTimeString("#1472_1", fallback: "Meetings DND"))
                .font(.title)
                .bold()
            Text(__designTimeString("#1472_2", fallback: "Version 1.0"))
                .font(.subheadline)

            Divider().padding(.vertical, __designTimeInteger("#1472_3", fallback: 8))

            VStack(alignment: .leading, spacing: __designTimeInteger("#1472_4", fallback: 4)) {
                Text(__designTimeString("#1472_5", fallback: "Meetings DND automatically manages Do Not Disturb & apps you choose when you join or leave Zoom meetings, helping you stay focused without interruptions."))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: __designTimeInteger("#1472_6", fallback: 12)))

            Divider().padding(.vertical, __designTimeInteger("#1472_7", fallback: 8))

            VStack(spacing: __designTimeInteger("#1472_8", fallback: 4)) {
                Text(__designTimeString("#1472_9", fallback: "This app is open source under the MIT License."))
                Link(__designTimeString("#1472_10", fallback: "View source on GitHub"), destination: URL(string: __designTimeString("#1472_11", fallback: "https://github.com/chrisbecher/meetings-dnd"))!)
            }
            .font(.system(size: __designTimeInteger("#1472_12", fallback: 11)))
            .multilineTextAlignment(.center)

            Spacer()

            Text(__designTimeString("#1472_13", fallback: "Created by Chris Becher"))
                .font(.footnote)
                .foregroundColor(.secondary)

            Text(__designTimeString("#1472_14", fallback: "© 2025 SnapOps Inc. All rights reserved."))
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(minWidth: __designTimeInteger("#1472_15", fallback: 400), minHeight: __designTimeInteger("#1472_16", fallback: 440))
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
            button.image = NSImage(systemSymbolName: __designTimeString("#1472_17", fallback: "equal"), accessibilityDescription: __designTimeString("#1472_18", fallback: "MeetingDND Icon"))
        }

        let titleItem = NSMenuItem()
        titleItem.action = #selector(showMainWindow)
        titleItem.attributedTitle = NSAttributedString(
            string: __designTimeString("#1472_19", fallback: "MeetingDND"),
            attributes: [.font: NSFont.boldSystemFont(ofSize: __designTimeInteger("#1472_20", fallback: 13))]
        )

        let menu = NSMenu()
        menu.addItem(titleItem)
        menu.addItem(NSMenuItem(title: __designTimeString("#1472_21", fallback: "About"), action: #selector(showAboutWindow), keyEquivalent: __designTimeString("#1472_22", fallback: "")))
        menu.addItem(.separator())
        menu.addItem(NSMenuItem(title: __designTimeString("#1472_23", fallback: "Quit"), action: #selector(quitApp), keyEquivalent: __designTimeString("#1472_24", fallback: "q")))

        statusItem.menu = menu

        // Main window
        window = NSWindow(
            contentRect: NSRect(x: __designTimeInteger("#1472_25", fallback: 0), y: __designTimeInteger("#1472_26", fallback: 0), width: __designTimeInteger("#1472_27", fallback: 500), height: __designTimeInteger("#1472_28", fallback: 220)),
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: __designTimeBoolean("#1472_29", fallback: false)
        )
        window.center()
        window.isReleasedWhenClosed = __designTimeBoolean("#1472_30", fallback: false)
        window.title = __designTimeString("#1472_31", fallback: "MeetingDND")
        window.contentView = NSHostingView(rootView: ContentView())

        showMainWindow()
    }

    @objc func showMainWindow() {
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: __designTimeBoolean("#1472_32", fallback: true))
    }

    @objc func showAboutWindow() {
        if aboutWindow == nil {
            aboutWindow = NSWindow(
                contentRect: NSRect(x: __designTimeInteger("#1472_33", fallback: 0), y: __designTimeInteger("#1472_34", fallback: 0), width: __designTimeInteger("#1472_35", fallback: 420), height: __designTimeInteger("#1472_36", fallback: 250)),
                styleMask: [.titled, .closable],
                backing: .buffered,
                defer: __designTimeBoolean("#1472_37", fallback: false)
            )
            aboutWindow?.center()
            aboutWindow?.isReleasedWhenClosed = __designTimeBoolean("#1472_38", fallback: false)
            aboutWindow?.title = __designTimeString("#1472_39", fallback: "About Meetings DND")
            aboutWindow?.contentView = NSHostingView(rootView: AboutView())
        }

        aboutWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: __designTimeBoolean("#1472_40", fallback: true))
    }

    @objc func quitApp() {
        NSApp.terminate(nil)
    }
}

#Preview {
    AboutView()
}
