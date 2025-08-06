import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/riipen/Desktop/xcode/MeetingDND/MeetingDND/views/AppSelectorView.swift", line: 1)
import SwiftUI
import AppKit


enum AppBehavior: String, CaseIterable, Codable, Identifiable {
    case quitOnEnterAndOpenOnLeave = "Quit on Join and Open on Leave"
    case quitOnEnterOnly = "Only Quit on Join"
    case openOnLeaveOnly = "Only Open on Leave"
    case doNothing = "Do Nothing"

    var id: String { self.rawValue }
}

struct AppInfo: Identifiable, Equatable, Codable {
    let id: UUID
    let name: String
    let urlPath: String
    var quitOnEnter: Bool
    var openOnLeave: Bool

    var url: URL { URL(fileURLWithPath: urlPath) }

    var behavior: AppBehavior {
        get {
            switch (quitOnEnter, openOnLeave) {
            case (true, true): return .quitOnEnterAndOpenOnLeave
            case (true, false): return .quitOnEnterOnly
            case (false, true): return .openOnLeaveOnly
            case (false, false): return .doNothing
            }
        }
        set {
            switch newValue {
            case .quitOnEnterAndOpenOnLeave:
                quitOnEnter = __designTimeBoolean("#7951_0", fallback: true)
                openOnLeave = __designTimeBoolean("#7951_1", fallback: true)
            case .quitOnEnterOnly:
                quitOnEnter = __designTimeBoolean("#7951_2", fallback: true)
                openOnLeave = __designTimeBoolean("#7951_3", fallback: false)
            case .openOnLeaveOnly:
                quitOnEnter = __designTimeBoolean("#7951_4", fallback: false)
                openOnLeave = __designTimeBoolean("#7951_5", fallback: true)
            case .doNothing:
                quitOnEnter = __designTimeBoolean("#7951_6", fallback: false)
                openOnLeave = __designTimeBoolean("#7951_7", fallback: false)
            }
        }
    }

    init(id: UUID = UUID(), name: String, urlPath: String, quitOnEnter: Bool = false, openOnLeave: Bool = false) {
        self.id = id
        self.name = name
        self.urlPath = urlPath
        self.quitOnEnter = quitOnEnter
        self.openOnLeave = openOnLeave
    }

    init(from appInfo: AppInfo) {
        self.id = appInfo.id
        self.name = appInfo.name
        self.urlPath = appInfo.url.path
        self.quitOnEnter = appInfo.quitOnEnter
        self.openOnLeave = appInfo.openOnLeave
    }

    var icon: NSImage? {
        let icon = NSWorkspace.shared.icon(forFile: url.path)
        icon.size = NSSize(width: __designTimeInteger("#7951_8", fallback: 24), height: __designTimeInteger("#7951_9", fallback: 24))
        return icon
    }
}


struct AppBehaviorPicker: View {
    @Binding var behavior: AppBehavior
    @State private var isHovering = false

    var imageBackground: some View {
        RoundedRectangle(cornerRadius: __designTimeInteger("#7951_10", fallback: 4))
            .fill(isHovering ? Color.white : Color.gray.opacity(__designTimeFloat("#7951_11", fallback: 0.1)))
            .overlay(
                isHovering ? nil :
                    RoundedRectangle(cornerRadius: __designTimeInteger("#7951_12", fallback: 4))
                        .stroke(Color.gray.opacity(__designTimeFloat("#7951_13", fallback: 0.5)), lineWidth: __designTimeFloat("#7951_14", fallback: 0.5))
            )
    }

    var pickerBackground: some View {
        RoundedRectangle(cornerRadius: __designTimeInteger("#7951_15", fallback: 4))
            .fill(isHovering ? Color.white : Color(.windowBackgroundColor))
            .overlay(
                isHovering ?
                RoundedRectangle(cornerRadius: __designTimeInteger("#7951_16", fallback: 4))
                    .stroke(Color.gray.opacity(__designTimeFloat("#7951_17", fallback: 0.4)), lineWidth: __designTimeInteger("#7951_18", fallback: 1))
                    .shadow(color: Color.black.opacity(__designTimeFloat("#7951_19", fallback: 0.4)), radius: __designTimeInteger("#7951_20", fallback: 4), x: __designTimeInteger("#7951_21", fallback: 0), y: __designTimeInteger("#7951_22", fallback: 2))
                : nil
            )
    }

    var body: some View {
        Picker(__designTimeString("#7951_23", fallback: ""), selection: $behavior) {
            ForEach(AppBehavior.allCases) { option in
                Text(option.rawValue).tag(option)
            }
        }
        .scaleEffect(__designTimeFloat("#7951_24", fallback: 1.1))
        .buttonStyle(BorderlessButtonStyle())
        .labelsHidden()
        .overlay {
            HStack {
                Text(behavior.rawValue)
                    .fixedSize()
                    .foregroundColor(.black)
                Image(systemName: __designTimeString("#7951_25", fallback: "chevron.up.chevron.down"))
                    .font(.system(size: __designTimeInteger("#7951_26", fallback: 10), weight: .bold))
                    .foregroundColor(.black)
                    .padding(__designTimeInteger("#7951_27", fallback: 2))
                    .padding(.horizontal, __designTimeInteger("#7951_28", fallback: 1))
                    .background(imageBackground)
            }
            .padding(__designTimeInteger("#7951_29", fallback: 2))
            .padding(.leading, __designTimeInteger("#7951_30", fallback: 10))
            .background(pickerBackground)
            .allowsHitTesting(__designTimeBoolean("#7951_31", fallback: false))
        }
        .onHover { hovering in
            isHovering = hovering
        }
    }
}


class AppListViewModel: ObservableObject {
    @Published var apps: [AppInfo] = [] {
        didSet {
            saveApps()
        }
    }
    
    private let iconCache = NSCache<NSString, NSImage>()
        
    
    // Keys for UserDefaults
    private let appsKey = "savedApps"
    
    init() {
        loadApps()
    }
    
    func addApp(url: URL) {
        guard url.pathExtension == __designTimeString("#7951_32", fallback: "app") else { return }
        
        let name = url.deletingPathExtension().lastPathComponent
        
        // Create Codable AppInfo
        let newApp = AppInfo(name: name, urlPath: url.path, quitOnEnter: __designTimeBoolean("#7951_33", fallback: true), openOnLeave: __designTimeBoolean("#7951_34", fallback: true))
        if !apps.contains(where: { $0.urlPath == newApp.urlPath }) {
            apps.append(newApp)
            print("Added app with path: \(url.path)")
        }
    }
    
    func removeApp(_ app: AppInfo) {
        if let index = apps.firstIndex(of: app) {
            apps.remove(at: index)
        }
    }
    
    func getQuitBundleIDs() -> [String] {
        let quitApps = apps.filter { $0.quitOnEnter }
        return quitApps.compactMap { Bundle(url: $0.url)?.bundleIdentifier }
    }

    func getOpenBundleIDs() -> [String] {
        let openApps = apps.filter { $0.openOnLeave }
        return openApps.compactMap { Bundle(url: $0.url)?.bundleIdentifier }
    }
    
    
    private func saveApps() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(apps)
            UserDefaults.standard.set(data, forKey: appsKey)
        } catch {
            print(__designTimeString("#7951_35", fallback: "Error encoding apps:"), error)
        }
    }
    
    private func loadApps() {
        guard let data = UserDefaults.standard.data(forKey: appsKey) else { return }
        do {
            let decoder = JSONDecoder()
            apps = try decoder.decode([AppInfo].self, from: data)
        } catch {
            print(__designTimeString("#7951_36", fallback: "Error decoding apps:"), error)
        }
    }
    
    func icon(for app: AppInfo) -> NSImage? {
        let cacheKey = app.id.uuidString as NSString

        if let cached = iconCache.object(forKey: cacheKey) {
            return cached
        }

        let icon = NSWorkspace.shared.icon(forFile: app.url.path)
        icon.size = NSSize(width: __designTimeInteger("#7951_37", fallback: 24), height: __designTimeInteger("#7951_38", fallback: 24))
        iconCache.setObject(icon, forKey: cacheKey)
        return icon
    }
}


struct AppSelectorView: View {
    @ObservedObject var viewModel: AppListViewModel
    @State private var showFilePicker = false
    @State private var selectedAppID: AppInfo.ID?

    var body: some View {
        SettingsContainer(heading: __designTimeString("#7951_39", fallback: "App Behaviour")) {
            VStack(spacing: __designTimeInteger("#7951_40", fallback: 0)) {
                Text(__designTimeString("#7951_41", fallback: "Define how you want applications to respond when you join or leave a meeting."))
                    .foregroundColor(Color.secondary)
                    .padding(.vertical)
                Divider()
                List(selection: $selectedAppID) {
                    ForEach($viewModel.apps) { $app in
                        VStack(alignment: .leading, spacing: __designTimeInteger("#7951_42", fallback: 6)) {
                            HStack {
                                if let icon = viewModel.icon(for: app) {
                                    Image(nsImage: icon)
                                        .resizable()
                                        .frame(width: __designTimeInteger("#7951_43", fallback: 24), height: __designTimeInteger("#7951_44", fallback: 24))
                                        .cornerRadius(__designTimeInteger("#7951_45", fallback: 4))
                                }

                                Text(app.name)
                                    .font(.system(size: __designTimeInteger("#7951_46", fallback: 14)))
                                    .lineLimit(__designTimeInteger("#7951_47", fallback: 1))

                                Spacer()
                                
                                AppBehaviorPicker(behavior: $app.behavior)
                            }
                        }
                        .padding(.vertical, __designTimeInteger("#7951_48", fallback: 8))
                        .listRowInsets(EdgeInsets(top: __designTimeInteger("#7951_49", fallback: 0), leading: __designTimeInteger("#7951_50", fallback: 4), bottom: __designTimeInteger("#7951_51", fallback: 0), trailing: __designTimeInteger("#7951_52", fallback: 4)))
                        .overlay(Divider().opacity(__designTimeFloat("#7951_53", fallback: 0.8)), alignment: .bottom)
                        .tag(app.id)
                    }
                }
                .frame(minHeight: __designTimeInteger("#7951_54", fallback: 232))
                .scrollContentBackground(.hidden)
                .windowResizeBehavior(.automatic)

                Divider()

                HStack(spacing: __designTimeInteger("#7951_55", fallback: 0)) {
                    Button(action: { showFilePicker = __designTimeBoolean("#7951_56", fallback: true) }) {
                        Image(systemName: __designTimeString("#7951_57", fallback: "plus"))
                            .scaleEffect(x: __designTimeFloat("#7951_58", fallback: 0.8), y: __designTimeFloat("#7951_59", fallback: 0.8))
                            .foregroundColor(.black.opacity(__designTimeFloat("#7951_60", fallback: 0.7)))
                            .padding(__designTimeInteger("#7951_61", fallback: 4))
                            .contentShape(Rectangle())
                    }

                    Divider()

                    Button(action: {
                        if let id = selectedAppID,
                           let app = viewModel.apps.first(where: { $0.id == id }) {
                            viewModel.removeApp(app)
                            selectedAppID = nil
                        }
                    }) {
                        Image(systemName: __designTimeString("#7951_62", fallback: "minus"))
                            .scaleEffect(x: __designTimeFloat("#7951_63", fallback: 0.8), y: __designTimeFloat("#7951_64", fallback: 0.8))
                            .foregroundColor(.black.opacity(selectedAppID != nil ? __designTimeFloat("#7951_65", fallback: 0.7) : __designTimeFloat("#7951_66", fallback: 0.3)))
                            .padding(__designTimeInteger("#7951_67", fallback: 6))
                            .contentShape(Rectangle())
                    }
                    .disabled(selectedAppID == nil)
                }
                .frame(height: __designTimeInteger("#7951_68", fallback: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .buttonStyle(BorderlessButtonStyle())
                .background(Color.gray.opacity(__designTimeFloat("#7951_69", fallback: 0.05)))
            }
        }
        .fileImporter(
            isPresented: $showFilePicker,
            allowedContentTypes: [.application],
            allowsMultipleSelection: __designTimeBoolean("#7951_70", fallback: true)
        ) { result in
            if case .success(let urls) = result {
                for url in urls {
                    viewModel.addApp(url: url)
                }
            }
        }
    }
}



#Preview {
    AppSelectorPreviewWrapper()
}

struct AppSelectorPreviewWrapper: View {
    @StateObject private var viewModel = AppListViewModel()

    var body: some View {
        AppSelectorView(viewModel: viewModel)
            .frame(width: __designTimeInteger("#7951_71", fallback: 450))
            .padding()
    }
}
