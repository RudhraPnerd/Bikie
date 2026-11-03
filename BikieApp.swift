//
//  BikieApp.swift
//  Bikie
//

import SwiftUI

@main
struct BikieApp: App {
    @StateObject private var routesStore = RoutesStore()
    @StateObject private var authManager = AuthManager()
    @StateObject private var notificationManager = NotificationManager()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(routesStore)
                .environmentObject(authManager)
                .environmentObject(notificationManager) // Inject into environment
                .onAppear {
                    notificationManager.requestAuthorization()
                }
        }
    }
}
