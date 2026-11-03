//
//  SettingsView.swift
//  Bikie
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var notificationManager: NotificationManager

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Notifications")) {
                    Button("Request Permission") {
                        notificationManager.requestAuthorization()
                    }
                    
                    Button("Send Test Notification (5s)") {
                        notificationManager.requestAuthorization()
                        notificationManager.scheduleTestNotification()
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
