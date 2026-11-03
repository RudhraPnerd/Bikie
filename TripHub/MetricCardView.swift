//
//  MetricCardView.swift
//  Bikie
//
//  Created by Rudhra T on 31/10/2026.
//

import SwiftUI

struct MetricCardView: View {
    let title: String
    let value: String
    let unit: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(unit)
                .font(.caption2)
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(.black.opacity(0.75))
        .cornerRadius(12)
    }
}
