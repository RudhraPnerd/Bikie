//
//  RoutesStore.swift
//  Bikie
//

import Foundation
import Combine
import SwiftUI
import CoreLocation

extension CLLocationCoordinate2D {
    public var coordinate: CLLocationCoordinate2D {
        return self
    }
}

struct CodableCoordinate: Codable {
    let latitude: Double
    let longitude: Double
    
    var clCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(_ coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}

struct BikeModel: Identifiable, Codable {
    let id: UUID
    var name: String
    var model: String?
    var type: String
    
    init(id: UUID = UUID(), name: String = "", model: String? = nil, type: String = "Road") {
        self.id = id
        self.name = name
        self.model = model
        self.type = type
    }
}

struct RouteModel: Identifiable, Codable {
    let id: UUID
    var name: String
    var distanceKm: Double
    var startDate: Date
    var isCompleted: Bool
    var bikeName: String?
    var codableCoordinates: [CodableCoordinate]
    
    var coordinates: [CLLocationCoordinate2D] {
        get { codableCoordinates.map { $0.clCoordinate } }
        set { codableCoordinates = newValue.map { CodableCoordinate($0) } }
    }
    
    init(
        id: UUID = UUID(),
        name: String,
        distanceKm: Double,
        startDate: Date = Date(),
        isCompleted: Bool = false,
        bikeName: String? = nil,
        coordinates: [CLLocationCoordinate2D] = []
    ) {
        self.id = id
        self.name = name
        self.distanceKm = distanceKm
        self.startDate = startDate
        self.isCompleted = isCompleted
        self.bikeName = bikeName
        self.codableCoordinates = coordinates.map { CodableCoordinate($0) }
    }
}

typealias BikieRoute = RouteModel

class RoutesStore: ObservableObject {
    @Published var routes: [RouteModel] = [] {
        didSet { saveRoutes() }
    }
    
    @Published var bikes: [BikeModel] = [] {
        didSet { saveBikes() }
    }
    
    private let routesKey = "saved_routes_key"
    private let bikesKey = "saved_bikes_key"
    
    init() {
        loadRoutes()
        loadBikes()
        
        // Add defaults if first launch
        if routes.isEmpty {
            routes = [
                RouteModel(name: "Morning Beach Loop", distanceKm: 14.2, startDate: Date(), isCompleted: false, bikeName: "Allez"),
                RouteModel(name: "River Trail Cruise", distanceKm: 8.5, startDate: Date(), isCompleted: true, bikeName: "Marlin")
            ]
        }
        if bikes.isEmpty {
            bikes = [
                BikeModel(name: "Specialized", model: "Allez", type: "Road"),
                BikeModel(name: "Trek", model: "Marlin", type: "Mountain")
            ]
        }
    }
    
    func addRoute(name: String, distanceKm: Double, startDate: Date, bikeName: String?, coordinates: [CLLocationCoordinate2D]) {
        let newRoute = RouteModel(name: name, distanceKm: distanceKm, startDate: startDate, isCompleted: false, bikeName: bikeName, coordinates: coordinates)
        routes.insert(newRoute, at: 0)
    }
    
    func markRouteAsCompleted(routeId: UUID) {
        if let index = routes.firstIndex(where: { $0.id == routeId }) {
            routes[index].isCompleted.toggle()
        }
    }
    
    func addBike(name: String, model: String?, type: String) {
        let newBike = BikeModel(name: name, model: model, type: type)
        bikes.append(newBike)
    }
    
    func deleteRoute(at offsets: IndexSet) {
        routes.remove(atOffsets: offsets)
    }
    
    func deleteBike(at offsets: IndexSet) {
        bikes.remove(atOffsets: offsets)
    }
    
    // MARK: - Persistence Helpers
        private func saveRoutes() {
            if let encoded = try? JSONEncoder().encode(routes) {
                UserDefaults.standard.set(encoded, forKey: routesKey)
            }
        }

        private func loadRoutes() {
            if let data = UserDefaults.standard.data(forKey: routesKey),
               let decoded = try? JSONDecoder().decode([RouteModel].self, from: data) {
                routes = decoded
            }
        }

        private func saveBikes() {
            if let encoded = try? JSONEncoder().encode(bikes) {
                UserDefaults.standard.set(encoded, forKey: bikesKey)
            }
        }

        private func loadBikes() {
            if let data = UserDefaults.standard.data(forKey: bikesKey),
               let decoded = try? JSONDecoder().decode([BikeModel].self, from: data) {
                bikes = decoded
            }
        }
}
