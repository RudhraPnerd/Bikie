//
//  RouteDetailView.swift
//  Bikie
//

import SwiftUI
import MapKit

struct RouteDetailView: View {
    @ObservedObject var routesStore: RoutesStore
    var routeId: UUID
    
    @State private var showingTripHub = false
    
    var route: RouteModel? {
        routesStore.routes.first(where: { $0.id == routeId })
    }
    
    var body: some View {
        Group {
            if let route = route {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Map Preview
                        Map(coordinateRegion: .constant(MKCoordinateRegion(
                            center: route.coordinates.first ?? CLLocationCoordinate2D(latitude: -37.9812, longitude: 145.1865),
                            span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                        )), annotationItems: route.coordinates.enumerated().map { DetailRoutePoint(id: $0.offset, coordinate: $0.element) }) { point in
                            MapMarker(coordinate: point.coordinate, tint: .accentColor)
                        }
                        .frame(height: 250)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(route.name)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            HStack {
                                Label("\(String(format: "%.1f", route.distanceKm)) km", systemImage: "map")
                                Spacer()
                                Label(route.bikeName ?? "Standard Bike", systemImage: "bicycle")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                        
                        // Start Ride Button
                        Button {
                            showingTripHub = true
                        } label: {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("Start Ride")
                                    .fontWeight(.bold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.vertical)
                }
                .navigationTitle("Route Details")
                .sheet(isPresented: $showingTripHub) {
                    TripHubView(route: route)
                }
            } else {
                Text("Route not found.")
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Local Route Point Helper for Detail Map
private struct DetailRoutePoint: Identifiable {
    let id: Int
    let coordinate: CLLocationCoordinate2D
}
