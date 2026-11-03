//
//  BikesView.swift
//  Bikie
//

import SwiftUI

struct BikesView: View {
    @ObservedObject var routesStore: RoutesStore
    @State private var showingAddBikeSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(routesStore.bikes) { bike in
                    NavigationLink(destination: BikeDetailView(bike: bike, routesStore: routesStore)) {
                        HStack(spacing: 14) {
                            Image(systemName: "bicycle.circle.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.accentColor)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(bike.name)
                                    .font(.headline)
                                if let model = bike.model, !model.isEmpty {
                                    Text("Model: **\(model)**")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Text("Type: \(bike.type)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .onDelete(perform: routesStore.deleteBike)
            }
            .navigationTitle("My Bikes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddBikeSheet = true
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.bold)
                    }
                }
            }
            .sheet(isPresented: $showingAddBikeSheet) {
                AddBikeView(routesStore: routesStore)
            }
        }
    }
}
