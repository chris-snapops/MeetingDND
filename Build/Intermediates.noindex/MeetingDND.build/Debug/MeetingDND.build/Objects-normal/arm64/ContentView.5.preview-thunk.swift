import func SwiftUI.__designTimeSelection

import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/riipen/Desktop/xcode/MeetingDND/MeetingDND/ContentView.swift", line: 1)
import SwiftUI
import AppKit

var hasStartedPolling = false

struct AccessibilityWarningView: View {
    var body: some View {
        __designTimeSelection(VStack(spacing: __designTimeInteger("#4518_0", fallback: 10)) {
            __designTimeSelection(Text(__designTimeString("#4518_1", fallback: "⚠️ Accessibility permission not granted"))
                .foregroundColor(.orange)
                .multilineTextAlignment(.center), "#4518.[3].[0].property.[0].[0].arg[1].value.[0]")

            __designTimeSelection(Button(__designTimeString("#4518_2", fallback: "Open Accessibility Settings")) {
                __designTimeSelection(openAccessibilitySettings(), "#4518.[3].[0].property.[0].[0].arg[1].value.[1].arg[1].value.[0]")
            }
            .buttonStyle(.borderedProminent), "#4518.[3].[0].property.[0].[0].arg[1].value.[1]")
        }, "#4518.[3].[0].property.[0].[0]")
    }
}

struct StatusBarView: View {
    let isZoomRunning: Bool
    let isInMeeting: Int

    var body: some View {
        __designTimeSelection(HStack(spacing: __designTimeInteger("#4518_3", fallback: 20)) {
            __designTimeSelection(LabelView(label: __designTimeString("#4518_4", fallback: "Zoom Status"), value: isZoomRunning ? __designTimeString("#4518_5", fallback: "Running") : __designTimeString("#4518_6", fallback: "Not Running"), color: isZoomRunning ? .green : .gray), "#4518.[4].[2].property.[0].[0].arg[1].value.[0]")

            __designTimeSelection(Divider()
                .frame(height: __designTimeInteger("#4518_7", fallback: 20)), "#4518.[4].[2].property.[0].[0].arg[1].value.[1]")

            __designTimeSelection(LabelView(label: __designTimeString("#4518_8", fallback: "Meeting Status"), value: isInMeeting == __designTimeInteger("#4518_9", fallback: 1) ? __designTimeString("#4518_10", fallback: "In a Meeting") : isInMeeting == __designTimeInteger("#4518_11", fallback: 0) ? __designTimeString("#4518_12", fallback: "Not in a Meeting"): __designTimeString("#4518_13", fallback: "Error"), color: isInMeeting == __designTimeInteger("#4518_14", fallback: 1) ? .green : isInMeeting == __designTimeInteger("#4518_15", fallback: 0) ? .gray : .orange), "#4518.[4].[2].property.[0].[0].arg[1].value.[2]")
        }
        .font(.caption)
        .padding(.vertical, __designTimeInteger("#4518_16", fallback: 6))
        .padding(.horizontal, __designTimeInteger("#4518_17", fallback: 12))
        .frame(maxWidth: .infinity)
        .background(__designTimeSelection(Color(.windowBackgroundColor), "#4518.[4].[2].property.[0].[0].modifier[4].arg[0].value"))
        .overlay(
            __designTimeSelection(Rectangle()
                .frame(height: __designTimeInteger("#4518_18", fallback: 1))
                .foregroundColor(__designTimeSelection(Color.gray.opacity(__designTimeFloat("#4518_19", fallback: 0.2)), "#4518.[4].[2].property.[0].[0].modifier[5].arg[0].value.modifier[1].arg[0].value")), "#4518.[4].[2].property.[0].[0].modifier[5].arg[0].value"),
            alignment: .top
        ), "#4518.[4].[2].property.[0].[0]")
    }
}

struct LabelView: View {
    let label: String
    let value: String
    let color: Color

    var body: some View {
        __designTimeSelection(HStack(spacing: __designTimeInteger("#4518_20", fallback: 4)) {
            __designTimeSelection(Text("\(__designTimeSelection(label, "#4518.[5].[3].property.[0].[0].arg[1].value.[0].arg[0].value.[1].value.arg[0].value")):")
                .foregroundColor(.secondary), "#4518.[5].[3].property.[0].[0].arg[1].value.[0]")
            __designTimeSelection(Text(__designTimeSelection(value, "#4518.[5].[3].property.[0].[0].arg[1].value.[1].arg[0].value"))
                .foregroundColor(__designTimeSelection(color, "#4518.[5].[3].property.[0].[0].arg[1].value.[1].modifier[0].arg[0].value"))
                .bold(), "#4518.[5].[3].property.[0].[0].arg[1].value.[1]")
        }, "#4518.[5].[3].property.[0].[0]")
    }
}


struct AppInfo: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let icon: NSImage?
    let url: URL
    var enabled: Bool
}


class AppListViewModel: ObservableObject {
    @Published var apps: [AppInfo] = []

    func addApp(url: URL) {
        guard url.pathExtension == __designTimeString("#4518_21", fallback: "app") else { return }

        let name = url.deletingPathExtension().lastPathComponent
        let icon = NSWorkspace.shared.icon(forFile: __designTimeSelection(url.path, "#4518.[7].[1].[2].value.modifier[0].arg[0].value"))
        icon.size = NSSize(width: __designTimeInteger("#4518_22", fallback: 24), height: __designTimeInteger("#4518_23", fallback: 24))

        let newApp = AppInfo(name: __designTimeSelection(name, "#4518.[7].[1].[4].value.arg[0].value"), icon: __designTimeSelection(icon, "#4518.[7].[1].[4].value.arg[1].value"), url: __designTimeSelection(url, "#4518.[7].[1].[4].value.arg[2].value"), enabled: __designTimeBoolean("#4518_24", fallback: true))

        if !apps.contains(where: { $0.url == url }) {
            __designTimeSelection(apps.append(__designTimeSelection(newApp, "#4518.[7].[1].[5].[0].[0].modifier[0].arg[0].value")), "#4518.[7].[1].[5].[0].[0]")
        }
    }

    func removeApp(at offsets: IndexSet) {
        __designTimeSelection(apps.remove(atOffsets: __designTimeSelection(offsets, "#4518.[7].[2].[0].modifier[0].arg[0].value")), "#4518.[7].[2].[0]")
    }

    func toggleApp(_ app: AppInfo) {
        if let index = apps.firstIndex(of: __designTimeSelection(app, "#4518.[7].[3].[0]")) {
            __designTimeSelection(apps[__designTimeSelection(index, "#4518.[7].[3].[0].[0].[0].[0]")].enabled.toggle(), "#4518.[7].[3].[0].[0].[0]")
        }
    }
}


struct AppSelectorView: View {
    @StateObject private var viewModel = AppListViewModel()
    @State private var showFilePicker = false

    var body: some View {
        __designTimeSelection(VStack(alignment: .leading) {
            __designTimeSelection(Text(__designTimeString("#4518_25", fallback: "Allow the applications below to control your computer."))
                .font(.headline)
                .padding(.bottom, __designTimeInteger("#4518_26", fallback: 8)), "#4518.[8].[2].property.[0].[0].arg[1].value.[0]")

            __designTimeSelection(List {
                __designTimeSelection(ForEach(__designTimeSelection(viewModel.apps, "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[0].value")) { app in
                    __designTimeSelection(HStack {
                        if let icon = app.icon {
                            __designTimeSelection(Image(nsImage: __designTimeSelection(icon, "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].[0].[0].arg[0].value"))
                                .resizable()
                                .frame(width: __designTimeInteger("#4518_27", fallback: 24), height: __designTimeInteger("#4518_28", fallback: 24))
                                .cornerRadius(__designTimeInteger("#4518_29", fallback: 4)), "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].[0].[0]")
                        }

                        __designTimeSelection(Text(__designTimeSelection(app.name, "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[1].arg[0].value"))
                            .font(__designTimeSelection(.system(size: __designTimeInteger("#4518_30", fallback: 14)), "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[1].modifier[0].arg[0]"))
                            .lineLimit(__designTimeInteger("#4518_31", fallback: 1))
                            .padding(.leading, __designTimeInteger("#4518_32", fallback: 5)), "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[1]")

                        __designTimeSelection(Spacer(), "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[2]")

                        __designTimeSelection(Toggle(__designTimeString("#4518_33", fallback: ""), isOn: __designTimeSelection(Binding(
                            get: { __designTimeSelection(app.enabled, "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[3].arg[1].value.arg[0].value.[0]") },
                            set: { newValue in
                                __designTimeSelection(viewModel.toggleApp(__designTimeSelection(app, "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[3].arg[1].value.arg[1].value.[0].modifier[0].arg[0].value")), "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[3].arg[1].value.arg[1].value.[0]")
                            }
                        ), "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[3].arg[1].value"))
                        .toggleStyle(__designTimeSelection(SwitchToggleStyle(tint: .pink), "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[3].modifier[0].arg[0].value"))
                        .scaleEffect(x: __designTimeFloat("#4518_34", fallback: 0.7), y: __designTimeFloat("#4518_35", fallback: 0.7), anchor: .center)
                        .labelsHidden(), "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[3]")
                    }
                    .padding(.vertical, __designTimeInteger("#4518_36", fallback: 2)), "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].arg[1].value.[0]")
                }
                .onDelete(perform: __designTimeSelection(viewModel.removeApp, "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0].modifier[0].arg[0].value")), "#4518.[8].[2].property.[0].[0].arg[1].value.[1].arg[0].value.[0]")
            }
            .frame(minHeight: __designTimeInteger("#4518_37", fallback: 150)), "#4518.[8].[2].property.[0].[0].arg[1].value.[1]")

            __designTimeSelection(HStack {
                __designTimeSelection(Button(action: {
                    showFilePicker = __designTimeBoolean("#4518_38", fallback: true)
                }) {
                    __designTimeSelection(Image(systemName: __designTimeString("#4518_39", fallback: "plus")), "#4518.[8].[2].property.[0].[0].arg[1].value.[2].arg[0].value.[0].arg[1].value.[0]")
                }, "#4518.[8].[2].property.[0].[0].arg[1].value.[2].arg[0].value.[0]")

                __designTimeSelection(Button(action: {
                    if let lastIndex = viewModel.apps.indices.last {
                        __designTimeSelection(viewModel.apps.remove(at: __designTimeSelection(lastIndex, "#4518.[8].[2].property.[0].[0].arg[1].value.[2].arg[0].value.[1].arg[0].value.[0].[0].[0].modifier[0].arg[0].value")), "#4518.[8].[2].property.[0].[0].arg[1].value.[2].arg[0].value.[1].arg[0].value.[0].[0].[0]")
                    }
                }) {
                    __designTimeSelection(Image(systemName: __designTimeString("#4518_40", fallback: "minus")), "#4518.[8].[2].property.[0].[0].arg[1].value.[2].arg[0].value.[1].arg[1].value.[0]")
                }
                .disabled(__designTimeSelection(viewModel.apps.isEmpty, "#4518.[8].[2].property.[0].[0].arg[1].value.[2].arg[0].value.[1].modifier[0].arg[0].value")), "#4518.[8].[2].property.[0].[0].arg[1].value.[2].arg[0].value.[1]")
            }
            .buttonStyle(__designTimeSelection(BorderlessButtonStyle(), "#4518.[8].[2].property.[0].[0].arg[1].value.[2].modifier[0].arg[0].value"))
            .padding(.top, __designTimeInteger("#4518_41", fallback: 4)), "#4518.[8].[2].property.[0].[0].arg[1].value.[2]")
        }
        .padding()
        .fileImporter(
            isPresented: __designTimeSelection($showFilePicker, "#4518.[8].[2].property.[0].[0].modifier[1].arg[0].value"),
            allowedContentTypes: [.application],
            allowsMultipleSelection: __designTimeBoolean("#4518_42", fallback: false)
        ) { result in
            if case .success(let urls) = result, let url = urls.first {
                __designTimeSelection(viewModel.addApp(url: __designTimeSelection(url, "#4518.[8].[2].property.[0].[0].modifier[1].arg[3].value.[0].[0].[0].modifier[0].arg[0].value")), "#4518.[8].[2].property.[0].[0].modifier[1].arg[3].value.[0].[0].[0]")
            }
        }, "#4518.[8].[2].property.[0].[0]")
    }
}


struct ContentView: View {
    @State private var isZoomRunning = false
    @State private var isInMeeting = 0
    @State private var accessibilityGranted = true
    @State private var DNDstatus = false
    @State private var updateDND = true
    @State private var checkFrequency = 2

    var body: some View {
        __designTimeSelection(VStack(spacing: __designTimeInteger("#4518_43", fallback: 0)) {
            __designTimeSelection(ScrollView {
                __designTimeSelection(VStack(spacing: __designTimeInteger("#4518_44", fallback: 20)) {
                    __designTimeSelection(Text(__designTimeString("#4518_45", fallback: "Zoom Meeting Status"))
                        .font(.title2)
                        .bold(), "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[0]")

                    if !accessibilityGranted {
                        __designTimeSelection(AccessibilityWarningView(), "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[1].[0].[0]")
                    }
                    
                    __designTimeSelection(VStack(alignment: .leading, spacing: __designTimeInteger("#4518_46", fallback: 20)) {
                        __designTimeSelection(HStack {
                            __designTimeSelection(Text(__designTimeString("#4518_47", fallback: "Update DND with meeting status")), "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2].arg[2].value.[0].arg[0].value.[0]")
                            __designTimeSelection(Spacer(), "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2].arg[2].value.[0].arg[0].value.[1]")
                            __designTimeSelection(Toggle(__designTimeString("#4518_48", fallback: ""), isOn: __designTimeSelection($updateDND, "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2].arg[2].value.[0].arg[0].value.[2].arg[1].value"))
                                .toggleStyle(__designTimeSelection(SwitchToggleStyle(), "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2].arg[2].value.[0].arg[0].value.[2].modifier[0].arg[0].value"))
                                .labelsHidden()
                                .scaleEffect(x: __designTimeFloat("#4518_49", fallback: 0.7), y: __designTimeFloat("#4518_50", fallback: 0.7), anchor: .center)
                                .padding(.vertical, __designTimeInteger("#4518_51", fallback: 4)), "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2].arg[2].value.[0].arg[0].value.[2]")
                        }, "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2].arg[2].value.[0]")

                        __designTimeSelection(HStack {
                            __designTimeSelection(Text(__designTimeString("#4518_52", fallback: "Check Frequency (sec)")), "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2].arg[2].value.[1].arg[0].value.[0]")
                            __designTimeSelection(Spacer(), "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2].arg[2].value.[1].arg[0].value.[1]")
                            __designTimeSelection(Stepper(value: __designTimeSelection($checkFrequency, "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2].arg[2].value.[1].arg[0].value.[2].arg[0].value"), in: __designTimeInteger("#4518_53", fallback: 1)...__designTimeInteger("#4518_54", fallback: 60)) {
                                __designTimeSelection(Text("\(__designTimeSelection(checkFrequency, "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2].arg[2].value.[1].arg[0].value.[2].arg[2].value.[0].arg[0].value.[1].value.arg[0].value"))")
                                    .frame(width: __designTimeInteger("#4518_55", fallback: 40), alignment: .trailing), "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2].arg[2].value.[1].arg[0].value.[2].arg[2].value.[0]")
                            }, "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2].arg[2].value.[1].arg[0].value.[2]")
                        }, "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2].arg[2].value.[1]")
                    }
                    .padding()
                    .frame(width: __designTimeInteger("#4518_56", fallback: 400)), "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[2]")
                    
                    __designTimeSelection(AppSelectorView()
                        .frame(width: __designTimeInteger("#4518_57", fallback: 450), height: __designTimeInteger("#4518_58", fallback: 300)), "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0].arg[1].value.[3]")
                    
                }
                .padding()
                .frame(maxWidth: .infinity), "#4518.[9].[6].property.[0].[0].arg[1].value.[0].arg[0].value.[0]")
            }, "#4518.[9].[6].property.[0].[0].arg[1].value.[0]")
            __designTimeSelection(StatusBarView(isZoomRunning: __designTimeSelection(isZoomRunning, "#4518.[9].[6].property.[0].[0].arg[1].value.[1].arg[0].value"), isInMeeting: __designTimeSelection(isInMeeting, "#4518.[9].[6].property.[0].[0].arg[1].value.[1].arg[1].value")), "#4518.[9].[6].property.[0].[0].arg[1].value.[1]")
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            if !hasStartedPolling {
                hasStartedPolling = __designTimeBoolean("#4518_59", fallback: true)
                __designTimeSelection(print(__designTimeString("#4518_60", fallback: "starting polling")), "#4518.[9].[6].property.[0].[0].modifier[1].arg[0].value.[0].[0].[1]")
                accessibilityGranted = isAccessibilityEnabled()
                if accessibilityGranted {
                    __designTimeSelection(pollZoom(), "#4518.[9].[6].property.[0].[0].modifier[1].arg[0].value.[0].[0].[3].[0].[0]")
                } else {
                    __designTimeSelection(pollAccessibility(), "#4518.[9].[6].property.[0].[0].modifier[1].arg[0].value.[0].[0].[3].[1].[0]")
                }
            }
        }, "#4518.[9].[6].property.[0].[0]")
    }

    func pollZoom() {
        __designTimeSelection(Timer.scheduledTimer(withTimeInterval: __designTimeFloat("#4518_61", fallback: 4.0), repeats: __designTimeBoolean("#4518_62", fallback: true)) { timer in
            if MeetingDND.isZoomRunning() {
                isZoomRunning = __designTimeBoolean("#4518_63", fallback: true)
                isInMeeting = isMeetingsInZoomMenuBar()
                

                
                if isInMeeting == __designTimeInteger("#4518_64", fallback: -1) {
                    __designTimeSelection(timer.invalidate(), "#4518.[9].[7].[0].arg[2].value.[0].[0].[2].[0].[0]")
                    __designTimeSelection(pollAccessibility(), "#4518.[9].[7].[0].arg[2].value.[0].[0].[2].[0].[1]")
                }
                
                if updateDND && isInMeeting != (DNDstatus ? __designTimeInteger("#4518_65", fallback: 1) : __designTimeInteger("#4518_66", fallback: 0)) {
                    if isInMeeting == __designTimeInteger("#4518_67", fallback: 1) {
                        __designTimeSelection(runDNDShortcut(action: __designTimeString("#4518_68", fallback: "Enable")), "#4518.[9].[7].[0].arg[2].value.[0].[0].[3].[0].[0].[0].[0]")
                        DNDstatus = __designTimeBoolean("#4518_69", fallback: true)
                    } else {
                        __designTimeSelection(runDNDShortcut(action: __designTimeString("#4518_70", fallback: "Disable")), "#4518.[9].[7].[0].arg[2].value.[0].[0].[3].[0].[0].[1].[0]")
                        DNDstatus = __designTimeBoolean("#4518_71", fallback: false)
                    }
                }
                
            } else {
                isZoomRunning = __designTimeBoolean("#4518_72", fallback: false)
                isInMeeting = __designTimeInteger("#4518_73", fallback: 0)
                if updateDND && DNDstatus {
                    __designTimeSelection(runDNDShortcut(action: __designTimeString("#4518_74", fallback: "Disable")), "#4518.[9].[7].[0].arg[2].value.[0].[1].[2].[0].[0]")
                    DNDstatus = __designTimeBoolean("#4518_75", fallback: false)
                }
            }
//            print("isZoomRunning: \(isZoomRunning)")
        }, "#4518.[9].[7].[0]")
    }
    
    func pollAccessibility() {
        __designTimeSelection(Timer.scheduledTimer(withTimeInterval: __designTimeFloat("#4518_76", fallback: 2.0), repeats: __designTimeBoolean("#4518_77", fallback: true)) { timer in
            accessibilityGranted = isAccessibilityEnabled()
            if accessibilityGranted {
                __designTimeSelection(timer.invalidate(), "#4518.[9].[8].[0].arg[2].value.[1].[0].[0]")
                __designTimeSelection(pollZoom(), "#4518.[9].[8].[0].arg[2].value.[1].[0].[1]")
            }
        }, "#4518.[9].[8].[0]")
    }
}

#Preview {
    ContentView()
}
