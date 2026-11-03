<!-- Bikie Project Badges -->
<p align="left">
  <img src="https://img.shields.io/badge/iOS-16.7%2B-blue?style=for-the-badge&logo=apple&logoColor=white" alt="iOS 16.7+" />
  <img src="https://img.shields.io/badge/SwiftUI-orange?style=for-the-badge&logo=swift&logoColor=white" alt="SwiftUI" />
  <img src="https://img.shields.io/badge/Xcode-15.0%2B-1575F9?style=for-the-badge&logo=xcode&logoColor=white" alt="Xcode 15+" />
  <img src="https://img.shields.io/badge/Status-Beta-brightgreen?style=for-the-badge" alt="Status Beta" />
  <img src="https://img.shields.io/badge/License-Apache_2.0-blue.svg?style=for-the-badge" alt="License Apache 2.0" />
</p>

# 🚴‍♂️ Bikie

> [!WARNING]
> This project is in **Beta Status**. Bugs may occur! Feel free to open issues or submit pull requests to help improve the app.

**Bikie** is an iOS route tracking and bike management application built natively with SwiftUI. Designed for cyclists, it helps you track your rides, monitor individual bike mileage, and manage your cycling statistics seamlessly.

---

## 📑 Table of Contents
- [✨ Features](#-features)
- [🛠️ Tech Stack & Requirements](#️-tech-stack--requirements)
- [📦 Dependencies](#-dependencies)
- [🚀 Getting Started & Installation](#-getting-started--installation)
- [👥 Contributing](#-contributing)
- [📄 License](#-license)

---

## ✨ Features

- **🗺️ Trip Hub & Route Tracking:** Record and map your cycling routes in real-time using MapKit.
- **🚲 Bike Management (`BikeDetailView`):** Track multiple bikes, view detailed model information, and automatically calculate total kilometers ridden.
- **🔔 Local Notifications:** Set ride reminders and test notification alerts.
- **📱 Modern Tabbed Navigation (`MainTabView`):** Seamlessly switch between Home, Routes, Bikes, and Settings.
- **🔐 Authentication:** Secure Google Sign-In integration.

---

## 🛠️ Tech Stack & Requirements

- **Minimum iOS Version:** iOS 16.7+
- **Framework:** SwiftUI & Combine
- **IDE:** Xcode 15.0+

---

## 📦 Dependencies

| Package / Framework | Purpose | Type |
| :--- | :--- | :--- |
| **SwiftUI** | Powers the modern user interface and navigation | Native Apple Framework |
| **MapKit** | Route tracking, GPS map rendering, and trip visualization | Native Apple Framework |
| **UserNotifications** | Local ride reminders and test alert notifications | Native Apple Framework |
| **Combine** | Reactive data flow and state management | Native Apple Framework |
| [GoogleSignIn-iOS](https://github.com/google/GoogleSignIn-iOS) | User authentication and Google Sign-In flow | Third-Party (SPM) |

---

## 🚀 Getting Started & Installation

Follow this step-by-step guide to download, open, and run **Bikie** on your local machine or physical device.

### Prerequisites

- **Xcode 15.0 or later** ([Download from the Mac App Store](https://developer.apple.com/xcode/))
- **macOS** supporting Xcode 15+ (macOS Ventura 13.5 or later recommended)
- An active **Apple ID** (free or paid) configured in Xcode for signing code to run on physical devices.

---

### Step 1: Download Source Files

1. Navigate to the main GitHub repository page for **Bikie**.
2. Click on the green **`<> Code`** button near the top right.
3. Select **Download ZIP** and save it to your computer.
4. Extract (unzip) the downloaded `.zip` file into your desired working directory.

---

### Step 2: Open in Xcode

1. Launch **Xcode** on your Mac.
2. From the welcome window or menu bar, select **Open Existing Project** (or go to `File > Open...`).
3. Navigate to the extracted root folder of **Bikie**, select the **`Bikie.xcodeproj`** file, and click **Open**.

---

### Step 3: Configure Signing & Run on Device (Optional)

If you want to run the app on a physical iPhone or iPad:

1. Connect your device to your computer using a USB cable.
2. Open the root project in the project sidebar and select the **Bikie** target.
3. Open the **Signing & Capabilities** tab and set your team to your [Apple Account](https://support.apple.com/apple-account).
4. Set the device target at the top of Xcode to your connected iPhone or iPad.
5. Hit the **Run** button (or press `Cmd + R`) to build and install the app onto your device!

> [!NOTE]
> Setting up your signing team in Xcode is a one-time configuration per machine/project clone.

---


## 📄 License

Distributed under the **Apache License 2.0**. See [`LICENSE`](LICENSE) for more information.
