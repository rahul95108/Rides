//
//  VehicleDetailViewModel.swift
//  Rides
//
//  Created by Rahulkumar Patel on 2024-09-28.
//

import SwiftUI

class VehicleDetailViewModel: ObservableObject {
    let ride: Ride
    
    @Published var carbonEmissions: Double = 0.0
    
    init(ride: Ride) {
        self.ride = ride
        self.carbonEmissions = calculateEmission(km: ride.kilometrage)
    }
    
    // MARK: - Calculate Emission Based on KM -
    
    private func calculateEmission(km: Int) -> Double {
        if km <= 5000 {
            return Double(km)
        } else {
            let emission5000 = 5000.0
            let emissionRemains = Double(km - 5000) * 1.5
            return emission5000 + emissionRemains
        }
    }
}
