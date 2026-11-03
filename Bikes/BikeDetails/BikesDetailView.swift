//
//  BikeDetailView.swift
//  Bikie
//

import SwiftUI

struct BikeDetailView: View {
    var bike: BikeModel
    @ObservedObject var routesStore: RoutesStore
    
    // Calculates total kilometers ridden with this bike from saved routes
    var totalKilometers: Double {
        routesStore.routes
            .filter { $0.bikeName == bike.name }
            .reduce(0) { $0 + $1.distanceKm }
    }
    
    // Filters routes associated with this bike
    var bikeRoutes: [RouteModel] {
        routesStore.routes.filter { $0.bikeName == bike.name }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Bike Header Card
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 16) {
                        Image(systemName: "bicycle")
                            .font(.system(size: 40))
                            .foregroundColor(.accentColor)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(bike.name)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            if let model = bike.model, !model.isEmpty {
                                Text("Model: \(model)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Text("Type: \(bike.type)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Statistics Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Statistics")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    HStack(spacing: 16) {
                        BikeMetricCard(
                            title: "Total Distance",
                            value: String(format: "%.1f km", totalKilometers),
                            icon: "map.fill"
                        )
                        BikeMetricCard(
                            title: "Rides Recorded",
                            value: "\(bikeRoutes.count)",
                            icon: "checkmark.circle.fill"
                        )
                    }
                    .padding(.horizontal)
                }
                
                // Associated Routes Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Associated Rides")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    if bikeRoutes.isEmpty {
                        Text("No routes recorded with this bike yet.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    } else {
                        ForEach(bikeRoutes) { route in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(route.name)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Text(route.startDate, style: .date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Text("\(String(format: "%.1f", route.distanceKm)) km")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.accentColor)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Bike Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
