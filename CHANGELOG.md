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

## [0.1.0-beta] - 2026-03-30

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
