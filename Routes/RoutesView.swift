//
//  RoutesView.swift
//  Bikie
//

import SwiftUI

struct RoutesView: View {
    @ObservedObject var routesStore: RoutesStore
    @State private var showingNewRouteSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(routesStore.routes) { route in
                    // NavigationLink lets the user tap any route to open RouteDetailView
                    NavigationLink(destination: RouteDetailView(routesStore: routesStore, routeId: route.id)) {
                        HStack(spacing: 14) {
                            Image(systemName: "map.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.accentColor)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(route.name)
                                    .font(.headline)
                                
                                HStack(spacing: 8) {
                                    Text("\(String(format: "%.1f", route.distanceKm)) km")
                                    Text("•")
                                    Text(route.bikeName ?? "Standard Bike")
                                }
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .onDelete(perform: routesStore.deleteRoute)
            }
            .navigationTitle("Saved Routes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingNewRouteSheet = true
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.bold)
                    }
                }
            }
            .sheet(isPresented: $showingNewRouteSheet) {
                NewRouteView(routesStore: routesStore)
            }
        }
    }
}
