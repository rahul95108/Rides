//
//  Ride.swift
//  Rides
//
//  Created by Rahulkumar Patel on 2024-09-27.
//

import Foundation

struct Ride: Identifiable, Codable, Hashable {
    let id: Int
    let vin: String
    let make_and_model: String
    let car_type: String
    let color: String
}
