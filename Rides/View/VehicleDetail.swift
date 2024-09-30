//
//  VehicleDetail.swift
//  Rides
//
//  Created by Rahulkumar Patel on 2024-09-27.
//

import SwiftUI

struct VehicleDetail: View {
    
    @StateObject private var viewModel: VehicleDetailViewModel
    
    init(ride: Ride) {
        _viewModel = StateObject(wrappedValue: VehicleDetailViewModel(ride: ride))
    }
    
    var body: some View {
        TabView {
            // Vehicle Details View
            VStack {
                Text("Make & Model: \(viewModel.ride.make_and_model)")
                Text("Vehicle Color: \(viewModel.ride.color)")
                Text("Car Type: \(viewModel.ride.car_type)")
                Text("Vin Number: \(viewModel.ride.vin)")
            }
            .padding(15)
            .tabItem { Text("Details") }
            
            // Carbon Emission View
            CarbonEmissionsView(viewModel: viewModel)
                .tabItem {
                    Text("Carbon Emissions")
                }
        }
        .tabViewStyle(PageTabViewStyle())
        .navigationTitle("Vehicle Details")
    }
}


// MARK: - Carbon Emissions View -

struct CarbonEmissionsView: View {
    @ObservedObject var viewModel: VehicleDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Estimated Carbon Emissions")
            Text("Kilometrage: \(viewModel.ride.kilometrage) km")
            Text("Carbon Emissions: \(viewModel.carbonEmissions, specifier: "%.2f") units")
        }
        .padding(15)
    }
}


#Preview {
    NavigationStack{
        VehicleDetail(ride:Ride(id: 8265, vin: "4062PE435MW889156", make_and_model: "Audi A5", car_type: "Cargo Van", color: "Grey", kilometrage: 81999))
    }
}
