//
//  NewRouteView.swift
//  Bikie
//

import SwiftUI
import MapKit

struct NewRouteView: View {
    @ObservedObject var routesStore: RoutesStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var routeName = ""
    @State private var startDate = Date()
    @State private var selectedBikeName: String = ""
    @State private var coordinates: [CLLocationCoordinate2D] = []
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -37.9812, longitude: 145.1865),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Route Information")) {
                    TextField("Route Name (e.g., Coastal Sprint)", text: $routeName)
                    DatePicker("Date & Time", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                    
                    if routesStore.bikes.isEmpty {
                        Text("No bikes available. Add one in the Bikes tab first!")
                            .foregroundColor(.secondary)
                    } else {
                        Picker("Select Bike", selection: $selectedBikeName) {
                            Text("None").tag("")
                            ForEach(routesStore.bikes) { bike in
                                Text("\(bike.name) \(bike.model ?? "")").tag(bike.name)
                            }
                        }
                    }
                }
                
                Section(header: Text("Draw Route on Map"), footer: Text("Tap anywhere on the map to drop route checkpoints precisely where you touch.")) {
                    // Tap-anywhere interactive map wrapper for iOS 16
                    RouteCreationMapView(region: $region, coordinates: $coordinates)
                        .frame(height: 300)
                        .cornerRadius(12)
                    
                    HStack {
                        Text("Checkpoints: \(coordinates.count)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Button("Clear Last Point") {
                            if !coordinates.isEmpty { coordinates.removeLast() }
                        }
                        .foregroundColor(.red)
                        .disabled(coordinates.isEmpty)
                    }
                }
                
                // Add NotificationManager inside NewRouteView
                @StateObject var notificationManager = NotificationManager()

                // Update the Save Route button inside Form:
                Section {
                    Button("Save Route") {
                        let distance = calculateTotalDistance()
                        
                        // 1. Add route to store
                        routesStore.addRoute(
                            name: routeName,
                            distanceKm: distance,
                            startDate: startDate,
                            bikeName: selectedBikeName.isEmpty ? nil : selectedBikeName,
                            coordinates: coordinates
                        )
                        
                        // 2. Schedule notification for ride date
                        notificationManager.scheduleRideReminder(
                            title: "Upcoming Ride! 🚴",
                            body: "Get ready for \(routeName)",
                            date: startDate
                        )
                        
                        // 3. (Optional) Fire quick test notification 5 seconds from now
                        notificationManager.scheduleTestNotification()
                        
                        dismiss()
                    }
                    .disabled(routeName.isEmpty || coordinates.count < 2)
                }
            }
            .navigationTitle("New Route")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .onAppear {
                if let firstBike = routesStore.bikes.first {
                    selectedBikeName = firstBike.name
                }
            }
        }
    }
    
    private func calculateTotalDistance() -> Double {
        guard coordinates.count >= 2 else { return 0.0 }
        var totalMeters: CLLocationDistance = 0
        for i in 0..<(coordinates.count - 1) {
            let start = CLLocation(latitude: coordinates[i].latitude, longitude: coordinates[i].longitude)
            let end = CLLocation(latitude: coordinates[i+1].latitude, longitude: coordinates[i+1].longitude)
            totalMeters += start.distance(from: end)
        }
        return totalMeters / 1000.0
    }
}

// MARK: - Tap-To-Drop Map UIViewRepresentable
struct RouteCreationMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var coordinates: [CLLocationCoordinate2D]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        
        // Add tap gesture recognizer to drop pins anywhere on tap
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: false)
        
        // Sync annotations with coordinates array
        let existingAnnotations = uiView.annotations.compactMap { $0 as? MKPointAnnotation }
        uiView.removeAnnotations(existingAnnotations)
        
        for (index, coord) in coordinates.enumerated() {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coord
            annotation.title = "Point \(index + 1)"
            uiView.addAnnotation(annotation)
        }
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: RouteCreationMapView
        
        init(_ parent: RouteCreationMapView) {
            self.parent = parent
        }
        
        @objc func handleMapTap(_ gesture: UITapGestureRecognizer) {
            guard let mapView = gesture.view as? MKMapView else { return }
            let point = gesture.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            
            DispatchQueue.main.async {
                self.parent.coordinates.append(coordinate)
            }
        }
    }
}
