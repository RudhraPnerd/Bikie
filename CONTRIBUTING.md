# Contributing to Bikie 🚴‍♂️

Thank you for your interest in contributing to **Bikie**! We welcome contributions from developers of all skill levels. Whether you are fixing a bug, adding a new feature, improving documentation, or reporting an issue, your help is greatly appreciated.

Please take a moment to review this document to make the contribution process smooth and effective for everyone.

---

## 📑 Table of Contents

- [Code of Conduct](#-code-of-conduct)
- [How Can I Contribute?](#-how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Features](#suggesting-features)
  - [Submitting Pull Requests](#submitting-pull-requests)
- [Development Setup](#-development-setup)
- [Code Style & Guidelines](#-code-style--guidelines)
- [License](#-license)

---

## 📜 Code of Conduct

We aim to foster an open, welcoming, and safe environment. Please maintain a positive, respectful, and constructive tone in all issues, pull requests, and discussions.

---

## 🤝 How Can I Contribute?

### Reporting Bugs

If you find a bug while using Bikie:

1. Check the existing [Issues](../../issues) tab to verify it hasn't already been reported.
2. If it hasn't been reported, open a **New Issue**.
3. Include a clear title and description:
   - **Steps to reproduce:** What steps trigger the bug?
   - **Expected behavior:** What should have happened?
   - **Actual behavior:** What actually happened?
   - **Environment:** iOS version, Xcode version, and device type/simulator.

### Suggesting Features

Feature requests are always welcome!

1. Check existing issues to make sure the feature isn't already requested or under development.
2. Open a **New Issue** with the title tag `[Feature Request]`.
3. Provide a clear description of the problem the feature solves and how you envision it working.

### Submitting Pull Requests

Follow these steps to submit your changes:

1. **Fork the repository** on GitHub.
2. **Clone your fork** to your local machine:
   ```bash
   git clone https://github.com/YOUR-USERNAME/Bikie.git
   cd Bikie
   ```
3. **Create a new branch** for your feature or bug fix:
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```
4. **Make your changes** in Xcode.
5. **Commit your changes** with a clear and descriptive commit message:
   ```bash
   git commit -m "Add feature: detailed summary of your changes"
   ```
6. **Push to your branch**:
   ```bash
   git push origin feature/your-feature-name
   ```
7. **Open a Pull Request (PR)** against the `main` branch of the main Bikie repository.
8. Describe your changes clearly in the PR description and link any related issues.

---

## 🛠️ Development Setup

1. Requirements:
   - **Xcode 15.0+**
   - **macOS Ventura 13.5+**
   - **iOS 16.7+** deployment target
2. Open `Bikie.xcodeproj` in Xcode.
3. Allow Swift Package Manager (SPM) to resolve third-party dependencies (such as `GoogleSignIn-iOS`).
4. Select a simulator or physical iOS device and press `Cmd + R` to build and run.

---

## 🎨 Code Style & Guidelines

To maintain clean and consistent code across the project, please follow these guidelines:

- **SwiftUI Best Practices:** Keep views modular and break complex UI down into smaller reusable subviews.
- **Indentation:** Use 4 spaces for indentation in Swift files (standard Xcode settings).
- **Naming Conventions:**
  - Use `CamelCase` for types, structs, protocols, and views (e.g., `BikeDetailView`, `TripManager`).
  - Use `lowerCamelCase` for variables, properties, and functions (e.g., `totalKilometers`, `calculateMileage()`).
- **Code Signing:** Do not commit personal Apple Developer Team IDs to the project file (`project.pbxproj`). Set the team to **None** before committing.

---

## 📄 License

By contributing to **Bikie**, you agree that your contributions will be licensed under the project's [Apache License 2.0](LICENSE).