//
//  MainTabView.swift
//  Bikie
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var routesStore: RoutesStore
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        TabView {
            // Pass the required parameters into ContentView
            ContentView(routesStore: routesStore, authManager: authManager)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            // Routes Tab
            RoutesView(routesStore: routesStore)
                .tabItem {
                    Label("Routes", systemImage: "map")
                }
            
            // Bikes Tab
            BikesView(routesStore: routesStore)
                .tabItem {
                    Label("Bikes", systemImage: "bicycle")
                }
            
            // Settings Tab
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}
