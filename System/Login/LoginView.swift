//
//  LoginView.swift
//  Bikie
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authManager: AuthManager
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "bicycle.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.accentColor)
            
            VStack(spacing: 8) {
                Text("Welcome to Bikie")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Track your rides, map your routes.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                authManager.handleGoogleSignIn()
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "globe")
                    Text("Sign in with Google")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
    }
}
