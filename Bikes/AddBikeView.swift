//
//  AddBikeView.swift
//  Bikie
//

import SwiftUI

struct AddBikeView: View {
    @ObservedObject var routesStore: RoutesStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var bikeName = ""
    @State private var bikeModel = ""
    @State private var bikeType = "Road"
    
    let bikeTypes = ["Road", "Mountain", "Gravel", "Commuter", "Electric"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Bike Details")) {
                    TextField("Brand / Make (e.g., Specialized)", text: $bikeName)
                    TextField("Model (e.g., Allez)", text: $bikeModel)
                    
                    Picker("Type", selection: $bikeType) {
                        ForEach(bikeTypes, id: \.self) { type in
                            Text(type).tag(type)
                        }
                    }
                }
                
                Section {
                    Button("Save Bike") {
                        if !bikeName.isEmpty {
                            routesStore.addBike(
                                name: bikeName,
                                model: bikeModel.isEmpty ? nil : bikeModel,
                                type: bikeType
                            )
                            dismiss()
                        }
                    }
                    .disabled(bikeName.isEmpty)
                }
            }
            .navigationTitle("Add New Bike")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
