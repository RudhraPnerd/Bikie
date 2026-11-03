//
//  AuthManager.swift
//  Bikie
//

import Foundation
import Combine
import GoogleSignIn
import UIKit

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var username: String = ""
    
    init() {
        checkPreviousSignIn()
    }
    
    func checkPreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
            guard let self = self else { return }
            if let user = user {
                DispatchQueue.main.async {
                    self.username = user.profile?.name ?? user.profile?.email ?? "Cyclist"
                    self.isAuthenticated = true
                }
            } else {
                DispatchQueue.main.async {
                    self.isAuthenticated = false
                    self.username = ""
                }
            }
        }
    }
    
    func handleGoogleSignIn() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("Google Sign-In error: Could not find a valid root view controller.")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            let profileName = user.profile?.name ?? user.profile?.email ?? "Cyclist"
            
            DispatchQueue.main.async {
                self.username = profileName
                self.isAuthenticated = true
            }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        DispatchQueue.main.async {
            self.isAuthenticated = false
            self.username = ""
        }
    }
}
