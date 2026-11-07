# Changelog

All notable changes to the **Bikie** iOS project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Planned / Upcoming Features
- 🗺️ **Enhanced GPS Route Recording:** Advanced polyline mapping and elevation tracking during active rides.
- 📊 **Ride Statistics Dashboard:** Detailed analytics for average speed, total distance, and weekly/monthly cycling trends.
- ⚙️ **User Preferences & Customization:** Extended settings screen for unit switching (km vs. miles) and notification scheduling.
- 🧪 **Unit & UI Test Suites:** Comprehensive automated testing setup for app stability.

---

## [0.1.0-beta] - 30-10-2026

### Added
- **Repository Setup & Open Source Release:**
  - Initialized public repository structure with Xcode project configuration (`Bikie.xcodeproj`).
  - Implemented standard open-source metadata and guidelines: `README.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, and `SUPPORT.md`.
- **Core App Architecture:**
  - `MainTabView`: Multi-tab navigation structure for seamless switching between Home, Routes, Bikes, and Settings.
  - `BikeDetailView`: Dedicated bike management interface for tracking individual bike models and total kilometers.
  - **MapKit Integration:** Initial setup for trip mapping and route visualization.
  - **Local Notifications:** Configured `UserNotifications` framework for ride reminders.
  - **Google Sign-In:** Integrated authentication flow via Swift Package Manager.

 ---

 ## [Unreleased]

 ### Planned / Upcoming Features
 App settings for users to configure and customize

 ---

 ## [0.2.0-beta] - 8-11-2026

 ### Added
 - **Configurable & Customizable Settings in Settings Page:**
   - **Profile & Account:** Username and email address fields.

   - **Appearance & Display:** App theme selection (System, Light, Dark), a live speedometer toggle, and a setting to keep the screen awake during a ride.

   - **Units & Measurements:** Distance units (Kilometers or Miles) and Speed units (km/h or mph).

   - **GPS & Navigation:** High-precision GPS toggle, auto-pause ride toggle, and an audio cue interval slider (1–15 minutes).

   - **Notifications & Audio:** Toggles for push notifications, ride reminders, and sound effects.

   - **Data & Sync:** Cloud sync, offline mode, and auto-export GPX toggles.

   - **System:** App version display (v0.2.0-beta) and a factory reset button with a confirmation alert.

> [!WARNING]
> This version has not been tested due to technical difficulties.
> This version is not for daily use and instead for testing.

> [!NOTE]
> Bikie might be discontinued after this version.
> Please contribute to the project to keep it running.
