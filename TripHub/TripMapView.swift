//
//  TripMapView.swift
//  Bikie
//
//  Created by Rudhra T on 31/10/2026.
//

import SwiftUI
import CoreLocation
import MapKit

struct TripMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var routeCoordinates: [CLLocationCoordinate2D]
    var userLocation: CLLocation?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        
        // Remove existing overlays and add the updated route polyline
        uiView.removeOverlays(uiView.overlays)
        if routeCoordinates.count > 1 {
            let polyline = MKPolyline(coordinates: routeCoordinates, count: routeCoordinates.count)
            uiView.addOverlay(polyline)
        }
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: TripMapView
        
        init(_ parent: TripMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .systemBlue
                renderer.lineWidth = 6.0
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}
