//
//  RecentRidesView.swift
//  Bikie
//

import SwiftUI

struct RecentRidesView: View {
    @ObservedObject var routesStore: RoutesStore
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(routesStore.routes) { route in
                    HStack(spacing: 14) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(route.isCompleted ? .green : .orange)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(route.name)
                                .font(.headline)
                            
                            HStack(spacing: 12) {
                                Text("\(String(format: "%.1f", route.distanceKm)) km")
                                Text("•")
                                Text(route.bikeName ?? "Standard Bike")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Button {
                            routesStore.markRouteAsCompleted(routeId: route.id)
                        } label: {
                            Image(systemName: route.isCompleted ? "checkmark.seal.fill" : "circle")
                                .font(.title2)
                                .foregroundColor(.accentColor)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: routesStore.deleteRoute)
            }
            .navigationTitle("Recent Rides")
        }
    }
}
