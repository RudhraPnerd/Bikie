//
//  CustomMapView.swift
//  Bikie
//

import SwiftUI
import MapKit

struct CustomMapView: View {
    @Binding var region: MKCoordinateRegion
    @Binding var routeCoordinates: [CLLocationCoordinate2D]
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .cornerRadius(16)
    }
}
