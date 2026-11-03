//
//  HomeHeaderView.swift
//  Bikie
//

import SwiftUI
import GoogleSignIn

struct HomeHeaderView: View {
    @ObservedObject var authManager: AuthManager
    
    var body: some View {
        HStack(spacing: 16) {
            if let user = GIDSignIn.sharedInstance.currentUser,
               let photoURL = user.profile?.imageURL(withDimension: 200) {
                AsyncImage(url: photoURL) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().aspectRatio(contentMode: .fill)
                    case .failure(_):
                        fallbackImage
                    case .empty:
                        ProgressView().frame(width: 50, height: 50)
                    @unknown default:
                        fallbackImage
                    }
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.accentColor.opacity(0.4), lineWidth: 2))
            } else {
                fallbackImage
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Welcome back,")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(authManager.username.isEmpty ? "Cyclist" : authManager.username)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            
            Spacer()
        }
    }
    
    private var fallbackImage: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width: 50, height: 50)
            .foregroundColor(.gray)
    }
}
