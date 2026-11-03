//
//  TripHubView.swift
//  Bikie
//

import SwiftUI
import CoreLocation
import MapKit
import Combine // Fixes @StateObject / @Published wrapper errors

struct TripHubView: View {
    var route: RouteModel
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var locationManager = LocationTracker()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Live Map View Tracker (Fixed argument label to userLocation:)
                TripMapView(
                    region: $locationManager.region,
                    routeCoordinates: route.coordinates,
                    userLocation: locationManager.currentLocation // Updated from currentCoordinate
                )
                .frame(height: 320)
                
                // Turn-by-turn banner simulation
                HStack(spacing: 14) {
                    Image(systemName: "arrow.turn.up.right")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.accentColor)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Next Turn in 200m")
                            .font(.headline)
                        Text("Follow \(route.name) path")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                .padding()
                
                // Metrics Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    MetricCardView(title: "Speed", value: String(format: "%.1f", locationManager.currentSpeed), unit: "km/h", color: .green)
                    MetricCardView(title: "Traveled", value: String(format: "%.2f", locationManager.distanceTraveled), unit: "km", color: .blue)
                    MetricCardView(title: "Remaining", value: String(format: "%.2f", max(0, route.distanceKm - locationManager.distanceTraveled)), unit: "km remaining", color: .orange)
                    MetricCardView(title: "Time Elapsed", value: locationManager.formattedElapsedTime, unit: "MM:SS", color: .purple)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // End Ride Button
                Button(role: .destructive) {
                    locationManager.stopTracking()
                    dismiss()
                } label: {
                    Text("End Ride")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.15))
                        .foregroundColor(.red)
                        .cornerRadius(14)
                }
                .padding()
            }
            .navigationTitle("Trip Hub")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                locationManager.startTracking()
            }
        }
    }
}

// MARK: - Location Tracker Helper
class LocationTracker: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -37.9812, longitude: 145.1865),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @Published var currentCoordinate: CLLocationCoordinate2D?
    @Published var currentLocation: CLLocation? // Added to satisfy TripMapView's CLLocation? type
    @Published var currentSpeed: Double = 0.0
    @Published var distanceTraveled: Double = 0.0
    @Published var formattedElapsedTime: String = "00:00"
    
    private var lastLocation: CLLocation?
    private var secondsElapsed: Int = 0
    private var timer: Timer?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
    }
    
    func startTracking() {
        manager.startUpdatingLocation()
        secondsElapsed = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.secondsElapsed += 1
            self?.updateElapsedTime()
        }
    }
    
    func stopTracking() {
        manager.stopUpdatingLocation()
        timer?.invalidate()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location // Store full CLLocation object
        currentCoordinate = location.coordinate
        region.center = location.coordinate
        
        if location.speed >= 0 {
            currentSpeed = location.speed * 3.6
        }
        
        if let last = lastLocation {
            let delta = last.distance(from: location)
            distanceTraveled += delta / 1000.0
        }
        lastLocation = location
    }
    
    private func updateElapsedTime() {
        let minutes = secondsElapsed / 60
        let seconds = secondsElapsed % 60
        formattedElapsedTime = String(format: "%02d:%02d", minutes, seconds)
    }
}
