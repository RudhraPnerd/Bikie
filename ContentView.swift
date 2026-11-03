//
//  ContentView.swift
//  Bikie
//

import SwiftUI
import MapKit

struct ContentView: View {
    @ObservedObject var routesStore: RoutesStore
    @ObservedObject var authManager: AuthManager
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -37.9812, longitude: 145.1865),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var routeCoordinates: [CLLocationCoordinate2D] = []
    @State private var showingNewRouteSheet = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    HomeHeaderView(authManager: authManager)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Live Radar")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        CustomMapView(region: $region, routeCoordinates: $routeCoordinates)
                            .frame(height: 220)
                            .padding(.horizontal)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Recent Routes")
                                .font(.headline)
                            Spacer()
                            Text("\(routesStore.routes.count) Total")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                        
                        if routesStore.routes.isEmpty {
                            Text("No routes created yet.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 20)
                        } else {
                            ForEach(routesStore.routes.prefix(3)) { route in
                                HStack {
                                    Image(systemName: "bicycle")
                                        .foregroundColor(.accentColor)
                                        .font(.title2)
                                        .frame(width: 40, height: 40)
                                        .background(Color.accentColor.opacity(0.1))
                                        .cornerRadius(8)
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(route.name).font(.subheadline).fontWeight(.semibold)
                                        Text("\(String(format: "%.1f", route.distanceKm)) km").font(.caption).foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right").font(.caption).foregroundColor(.secondary)
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingNewRouteSheet = true
                    } label: {
                        Label("New Route", systemImage: "plus.circle.fill")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                }
            }
            .sheet(isPresented: $showingNewRouteSheet) {
                NewRouteView(routesStore: routesStore)
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
}
