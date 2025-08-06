import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/riipen/Desktop/xcode/MeetingDND/MeetingDND/views/SettingsContainers.swift", line: 1)
//
//  SettingsContainers.swift
//  MeetingDND
//
//  Created by Riipen on 2025-08-03.
//

import SwiftUI


struct SettingsContainer<Content: View>: View {
    let heading: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: __designTimeInteger("#6805_0", fallback: 0)) {
            if !heading.isEmpty {
                HStack {
                    Text(heading)
                        .font(.system(size: __designTimeInteger("#6805_1", fallback: 12), weight: .bold))
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.leading, __designTimeInteger("#6805_2", fallback: 12))
                .padding(.bottom, __designTimeInteger("#6805_3", fallback: 8))
            }

            VStack(alignment: .leading, spacing: __designTimeInteger("#6805_4", fallback: 0)) {
                content
            }
            .background(Color.gray.opacity(__designTimeFloat("#6805_5", fallback: 0.03)))
            .cornerRadius(__designTimeInteger("#6805_6", fallback: 4))
            .overlay(
                RoundedRectangle(cornerRadius: __designTimeInteger("#6805_7", fallback: 4))
                    .stroke(Color.gray, lineWidth: __designTimeFloat("#6805_8", fallback: 0.2))
            )
            .padding(.bottom, __designTimeInteger("#6805_9", fallback: 16))
        }
    }
}

struct SettingsContainers: View {
    var body: some View {
        SettingsContainer(heading: __designTimeString("#6805_10", fallback: "Hello")) {
            Text(__designTimeString("#6805_11", fallback: "World!"))
                .padding()
        }
        .padding()
    }
}

#Preview {
    SettingsContainers()
}
