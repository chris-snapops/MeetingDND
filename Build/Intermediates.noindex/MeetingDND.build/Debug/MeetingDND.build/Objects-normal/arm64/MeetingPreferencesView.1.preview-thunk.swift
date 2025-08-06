import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/riipen/Desktop/xcode/MeetingDND/MeetingDND/views/MeetingPreferencesView.swift", line: 1)
import SwiftUI

struct MeetingPreferencesView: View {
    @Binding var settingUpdateDND: Bool
    @Binding var settingPollZoom: Bool
    @Binding var settingPollMeet: Bool
    @Binding var settingPollTeams: Bool

    var body: some View {
        VStack {
            
            SettingsContainer(heading: __designTimeString("#6791_0", fallback: "")) {
                
                VStack(alignment: .leading, spacing: __designTimeInteger("#6791_1", fallback: 8)) {
                    settingRow(title: __designTimeString("#6791_2", fallback: "Update DND with meeting status"), boolBinding: $settingUpdateDND, userDefaultsKey: __designTimeString("#6791_3", fallback: "settingUpdateDND"))
                }
                .padding(.horizontal)
                .padding(.vertical, __designTimeInteger("#6791_4", fallback: 12))
            }
            
            SettingsContainer(heading: __designTimeString("#6791_5", fallback: "MeetingApps")) {
                
                VStack(alignment: .leading, spacing: __designTimeInteger("#6791_6", fallback: 8)) {
                    settingRow(title: __designTimeString("#6791_7", fallback: "Check Zoom"), boolBinding: $settingPollZoom, userDefaultsKey: __designTimeString("#6791_8", fallback: "settingPollZoom"))
                    Divider()
                    settingRow(title: __designTimeString("#6791_9", fallback: "Check Google Meet"), boolBinding: $settingPollMeet, userDefaultsKey: __designTimeString("#6791_10", fallback: "settingPollMeet"))
                    Divider()
                    settingRow(title: __designTimeString("#6791_11", fallback: "Check MS Teams"), boolBinding: $settingPollTeams, userDefaultsKey: __designTimeString("#6791_12", fallback: "settingPollTeams"))
                }
                .padding(.horizontal)
                .padding(.vertical, __designTimeInteger("#6791_13", fallback: 12))
            }
        }
    }

    @ViewBuilder
    private func settingRow(title: String, boolBinding: Binding<Bool>, userDefaultsKey: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Toggle(__designTimeString("#6791_14", fallback: ""), isOn: boolBinding)
                .onChange(of: boolBinding.wrappedValue) { _, newValue in
                    UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
                }
                .toggleStyle(SwitchToggleStyle())
                .labelsHidden()
                .scaleEffect(x: __designTimeFloat("#6791_15", fallback: 0.7), y: __designTimeFloat("#6791_16", fallback: 0.7), anchor: .center)
        }
    }
}


#Preview {
    SeetingsPreviewWrapper()
}

struct SeetingsPreviewWrapper: View {
    @State private var settingUpdateDND = UserDefaults.standard.bool(forKey: "settingUpdateDND")
    @State private var settingPollZoom = UserDefaults.standard.bool(forKey: "settingPollZoom")
    @State private var settingPollMeet = UserDefaults.standard.bool(forKey: "settingPollMeet")
    @State private var settingPollTeams = UserDefaults.standard.bool(forKey: "settingPollTeams")

    var body: some View {
        MeetingPreferencesView(
            settingUpdateDND: $settingUpdateDND,
            settingPollZoom: $settingPollZoom,
            settingPollMeet: $settingPollMeet,
            settingPollTeams: $settingPollTeams
        )
        .frame(width: __designTimeInteger("#6791_17", fallback: 350))
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}
