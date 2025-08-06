import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/riipen/Desktop/xcode/MeetingDND/MeetingDND/ContentView.swift", line: 1)
import SwiftUI
import AppKit

var hasStartedPolling = false

enum MeetingStatus: Int {
    case errored = -1
    case notPolling = 0
    case polling = 1
    case appNotRunning = 2
    case appRunningNotInMeeting = 3
    case appRunningInMeeting = 4
    
    var isAppRunning: Bool {
        self == .appRunningInMeeting || self == .appRunningNotInMeeting
    }

    var display: (text: String, color: Color) {
        switch self {
        case .appRunningInMeeting:
            return (__designTimeString("#9659_0", fallback: "In Meeting"), .blue.opacity(__designTimeInteger("#9659_1", fallback: 1)))
        case .appRunningNotInMeeting:
            return (__designTimeString("#9659_2", fallback: "Not in Meeting"), .blue.opacity(__designTimeFloat("#9659_3", fallback: 0.7)))
        case .appNotRunning:
            return (__designTimeString("#9659_4", fallback: "Not Running"), .secondary)
        case .notPolling:
            return (__designTimeString("#9659_5", fallback: "Not Checking"), .secondary)
        case .errored:
            return (__designTimeString("#9659_6", fallback: "Error"), .orange)
        default:
            return (__designTimeString("#9659_7", fallback: "..."), .secondary)
        }
    }
}

struct AccessibilityWarningView: View {
    var body: some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(__designTimeFloat("#9659_8", fallback: 0.4))
                .edgesIgnoringSafeArea(.all)

            // Modal content
            VStack(spacing: __designTimeInteger("#9659_9", fallback: 16)) {
                Text(__designTimeString("#9659_10", fallback: "⚠️ Accessibility permission not granted"))
                    .font(.headline)
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button(__designTimeString("#9659_11", fallback: "Open Accessibility Settings")) {
                    openAccessibilitySettings()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .frame(maxWidth: __designTimeInteger("#9659_12", fallback: 300))
            .background(.background)
            .cornerRadius(__designTimeInteger("#9659_13", fallback: 8))
            .shadow(radius: __designTimeInteger("#9659_14", fallback: 20))
        }
    }
}


struct ContentView: View {
    @State private var accessibilityGranted = true
    
    @State private var ZoomState = MeetingStatus.polling
    @State private var MeetState = MeetingStatus.polling
    @State private var TeamsState = MeetingStatus.polling
    @State private var DNDstatus = false
    
    @State private var settingUpdateDND = UserDefaults.standard.bool(forKey: "settingUpdateDND")
    @State private var settingPollZoom = UserDefaults.standard.bool(forKey: "settingPollZoom")
    @State private var settingPollMeet = UserDefaults.standard.bool(forKey: "settingPollMeet")
    @State private var settingPollTeams = UserDefaults.standard.bool(forKey: "settingPollTeams")
    
    @StateObject private var viewModel = AppListViewModel()
    
    var body: some View {
        VStack(spacing: __designTimeInteger("#9659_15", fallback: 0)) {
            ZStack() {
                HStack(spacing: __designTimeInteger("#9659_16", fallback: 16)) {
                    MeetingPreferencesView(
                        settingUpdateDND: $settingUpdateDND,
                        settingPollZoom: $settingPollZoom,
                        settingPollMeet: $settingPollMeet,
                        settingPollTeams: $settingPollTeams
                    )
                    .frame(width: __designTimeInteger("#9659_17", fallback: 450))
                    .frame(maxHeight: .infinity, alignment: .top)
                    
                    AppSelectorView(viewModel: viewModel)
                    .frame(width: __designTimeInteger("#9659_18", fallback: 450))
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                .frame(height: __designTimeInteger("#9659_19", fallback: 350))
                .padding()
                
                if !accessibilityGranted {
                    AccessibilityWarningView()
                }
            }
            
            Spacer()
            
            StatusBarView(
                ZoomState: ZoomState,
                MeetState: MeetState,
                TeamsState: TeamsState
            )
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            if !hasStartedPolling {
                hasStartedPolling = __designTimeBoolean("#9659_20", fallback: true)
                print(__designTimeString("#9659_21", fallback: "starting polling"))
                accessibilityGranted = isAccessibilityEnabled()
                if accessibilityGranted {
                    pollMeetingApps()
                } else {
                    pollAccessibility()
                }
            }
        }
    }

    func pollMeetingApps() {
        Timer.scheduledTimer(withTimeInterval: __designTimeFloat("#9659_22", fallback: 2.0), repeats: __designTimeBoolean("#9659_23", fallback: true)) { timer in
//            print("polling Zoom? \(settingPollZoom)")
//            print("polling Meet? \(settingPollMeet)")
//            print("polling Teams? \(settingPollTeams)")
            if settingPollZoom {
                // if zoom is running, check if meetings is in the menu bar.
                //   if not, return .appNotRunning
                let newState = MeetingDND.isZoomRunning() ? isMeetingsInZoomMenuBar() : MeetingStatus.appNotRunning
                
                // Stop polling if an error occurs
                if newState == .errored {
                    ZoomState = .errored
                    timer.invalidate()
                    pollAccessibility()
                    return
                }
                
                // If ZoomState changed, update ZoomState & DND & Apps
                if ZoomState != newState {
                    ZoomState = newState
                    
                    if ZoomState == .appRunningInMeeting {
                        if settingUpdateDND {
                            enableDND()
                        }
                        quitApps(appIds: viewModel.getQuitBundleIDs())
                    } else if ZoomState == .appRunningNotInMeeting {
                        if settingUpdateDND {
                            disableDND()
                        }
                        openApps(appIds: viewModel.getOpenBundleIDs())
                    }
                }
            } else {
                if ZoomState != .notPolling {
                    ZoomState = .notPolling
                }
            }
        }
    }
    
    func pollAccessibility() {
        Timer.scheduledTimer(withTimeInterval: __designTimeFloat("#9659_24", fallback: 2.0), repeats: __designTimeBoolean("#9659_25", fallback: true)) { timer in
            let newAccessibilityGranted = isAccessibilityEnabled()
            
            // update if changed
            if accessibilityGranted != newAccessibilityGranted  {
                accessibilityGranted = newAccessibilityGranted
            }
            
            // stop polling if accessibility was granted
            if accessibilityGranted {
                timer.invalidate()
                pollMeetingApps()
            }
        }
    }
}

#Preview {
    ContentView()
}
