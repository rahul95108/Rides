//
//  VehicleDetail.swift
//  Rides
//
//  Created by Rahulkumar Patel on 2024-09-27.
//

import SwiftUI

struct VehicleDetail: View {
    var ride: Ride
    
    var body: some View {
        VStack {
            Text("Make & Model: \(ride.make_and_model)")
            Text("VIN: \(ride.vin)")
            Text("Car Type: \(ride.car_type)")
            Text("Color: \(ride.color)")
        }
        .padding(15)
    }
}

#Preview {
    NavigationStack{
        VehicleDetail(ride:Ride(id: 8265, vin: "4062PE435MW889156", make_and_model: "Audi A5", car_type: "Cargo Van", color: "Grey"))
    }
}
