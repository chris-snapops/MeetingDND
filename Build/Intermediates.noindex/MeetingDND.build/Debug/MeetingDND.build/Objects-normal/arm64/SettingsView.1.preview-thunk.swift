import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/riipen/Desktop/xcode/MeetingDND/MeetingDND/views/SettingsView.swift", line: 1)
import SwiftUI

struct SettingsView: View {
    @Binding var settingUpdateDND: Bool
    @Binding var settingPollZoom: Bool
    @Binding var settingPollMeet: Bool
    @Binding var settingPollTeams: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: __designTimeInteger("#38591_0", fallback: 0)) {
            HStack {
                Text(__designTimeString("#38591_1", fallback: "Meeting Preferences"))
                    .font(.system(size: __designTimeInteger("#38591_2", fallback: 13)))
                    .foregroundColor(.secondary)
                Spacer()
            }
            .frame(height: __designTimeInteger("#38591_3", fallback: 30))
            .padding(.leading, __designTimeInteger("#38591_4", fallback: 12))
            .padding(.top, __designTimeInteger("#38591_5", fallback: 2))

            Divider()
            
            VStack(alignment: .leading, spacing: __designTimeInteger("#38591_6", fallback: 8)) {
                settingRow(title: __designTimeString("#38591_7", fallback: "Check Zoom"), boolBinding: $settingPollZoom, userDefaultsKey: __designTimeString("#38591_8", fallback: "settingPollZoom"))
                Divider()
                settingRow(title: __designTimeString("#38591_9", fallback: "Check Google Meet"), boolBinding: $settingPollMeet, userDefaultsKey: __designTimeString("#38591_10", fallback: "settingPollMeet"))
                Divider()
                settingRow(title: __designTimeString("#38591_11", fallback: "Check MS Teams"), boolBinding: $settingPollTeams, userDefaultsKey: __designTimeString("#38591_12", fallback: "settingPollTeams"))
            }
            .padding()
            
            Divider()
            
            VStack(alignment: .leading, spacing: __designTimeInteger("#38591_13", fallback: 8)) {
                settingRow(title: __designTimeString("#38591_14", fallback: "Update DND with meeting status"), boolBinding: $settingUpdateDND, userDefaultsKey: __designTimeString("#38591_15", fallback: "settingUpdateDND"))
            }
            .padding()
            
            Spacer()
        }
        .frame(minHeight: __designTimeInteger("#38591_16", fallback: 215))
        .background(Color.gray.opacity(__designTimeFloat("#38591_17", fallback: 0.03)))
        .cornerRadius(__designTimeInteger("#38591_18", fallback: 4))
        .overlay(
            RoundedRectangle(cornerRadius: __designTimeInteger("#38591_19", fallback: 4))
                .stroke(Color.gray, lineWidth: __designTimeFloat("#38591_20", fallback: 0.2))
        )
    }

    @ViewBuilder
    private func settingRow(title: String, boolBinding: Binding<Bool>, userDefaultsKey: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Toggle(__designTimeString("#38591_21", fallback: ""), isOn: boolBinding)
                .onChange(of: boolBinding.wrappedValue) { _, newValue in
                    UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
                }
                .toggleStyle(SwitchToggleStyle())
                .labelsHidden()
                .scaleEffect(x: __designTimeFloat("#38591_22", fallback: 0.7), y: __designTimeFloat("#38591_23", fallback: 0.7), anchor: .center)
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
        SettingsView(
            settingUpdateDND: $settingUpdateDND,
            settingPollZoom: $settingPollZoom,
            settingPollMeet: $settingPollMeet,
            settingPollTeams: $settingPollTeams
        )
        .frame(width: __designTimeInteger("#38591_24", fallback: 350))
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}
