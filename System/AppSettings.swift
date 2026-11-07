//
//  AppSettings.swift
//  Bikie
//
//  Created by Rudhra T on 8/11/2026.
//

import Foundation
import SwiftUI
import Combine

enum AppTheme: String, CaseIterable, Identifiable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
    
    var id: String { self.rawValue }
}

enum DistanceUnit: String, CaseIterable, Identifiable {
    case metric = "Kilometers (km)"
    case imperial = "Miles (mi)"
    
    var id: String { self.rawValue }
}

enum SpeedUnit: String, CaseIterable, Identifiable {
    case kmh = "km/h"
    case mph = "mph"
    
    var id: String { self.rawValue }
}

class AppSettings: ObservableObject {
    static let shared = AppSettings()
    
    // MARK: - General & Profile
    @AppStorage("username") var username: String = "Rider"
    @AppStorage("userEmail") var userEmail: String = ""
    @AppStorage("selectedLanguage") var selectedLanguage: String = "English"
    
    // MARK: - Appearance & Display
    @AppStorage("appThemeRaw") private var appThemeRaw: String = AppTheme.system.rawValue
    var appTheme: AppTheme {
        get { AppTheme(rawValue: appThemeRaw) ?? .system }
        set { appThemeRaw = newValue.rawValue; objectWillChange.send() }
    }
    @AppStorage("showSpeedometer") var showSpeedometer: Bool = true
    @AppStorage("keepScreenAwake") var keepScreenAwake: Bool = true
    
    // MARK: - Units & Measurement
    @AppStorage("distanceUnitRaw") private var distanceUnitRaw: String = DistanceUnit.metric.rawValue
    var distanceUnit: DistanceUnit {
        get { DistanceUnit(rawValue: distanceUnitRaw) ?? .metric }
        set { distanceUnitRaw = newValue.rawValue; objectWillChange.send() }
    }
    
    @AppStorage("speedUnitRaw") private var speedUnitRaw: String = SpeedUnit.kmh.rawValue
    var speedUnit: SpeedUnit {
        get { SpeedUnit(rawValue: speedUnitRaw) ?? .kmh }
        set { speedUnitRaw = newValue.rawValue; objectWillChange.send() }
    }
    
    // MARK: - Navigation & GPS
    @AppStorage("highPrecisionGPS") var highPrecisionGPS: Bool = true
    @AppStorage("autoPauseRides") var autoPauseRides: Bool = true
    @AppStorage("audioCueInterval") var audioCueInterval: Double = 5.0 // minutes
    
    // MARK: - Notifications & Alerts
    @AppStorage("pushNotificationsEnabled") var pushNotificationsEnabled: Bool = true
    @AppStorage("rideReminderAlerts") var rideReminderAlerts: Bool = false
    @AppStorage("soundEffectsEnabled") var soundEffectsEnabled: Bool = true
    
    // MARK: - Data & Storage
    @AppStorage("cloudSyncEnabled") var cloudSyncEnabled: Bool = true
    @AppStorage("offlineMode") var offlineMode: Bool = false
    @AppStorage("autoExportGPX") var autoExportGPX: Bool = false
    
    // MARK: - Reset Function
    func resetToDefaults() {
        username = "Rider"
        userEmail = ""
        selectedLanguage = "English"
        appThemeRaw = AppTheme.system.rawValue
        showSpeedometer = true
        keepScreenAwake = true
        distanceUnitRaw = DistanceUnit.metric.rawValue
        speedUnitRaw = SpeedUnit.kmh.rawValue
        highPrecisionGPS = true
        autoPauseRides = true
        audioCueInterval = 5.0
        pushNotificationsEnabled = true
        rideReminderAlerts = false
        soundEffectsEnabled = true
        cloudSyncEnabled = true
        offlineMode = false
        autoExportGPX = false
        objectWillChange.send()
    }
}
