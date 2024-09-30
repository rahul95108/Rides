//
//  ContentView.swift
//  Rides
//
//  Created by Rahulkumar Patel on 2024-09-27.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RideViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                // TextField for entering number of vehicles
                TextField("Enter Number of Vehicles", text: $viewModel.vehicleNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                // Submit button to fetch vehicles
                Button(action: {
                    if viewModel.vehicleNumber.isEmpty {
                        viewModel.showAlert = true
                        viewModel.errorMessage = "Enter Number of Vehicles"
                    } else {
                        viewModel.dismissKeyboard()
                        viewModel.sortOption = .vin
                        viewModel.fetchVehicles()
                    }
                }) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 90, height: 45)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(15)
                .alert(viewModel.errorMessage, isPresented: $viewModel.showAlert) {
                    Button("OK") {}
                }
                
                // Show loading indicator if data is being fetched
                if viewModel.isLoading {
                    ProgressView("Vehicle Loading..")
                }
                
                // Sorting picker if there are vehicles to sort
                if viewModel.sortedList.count > 0 {
                    Picker("Sort by", selection: $viewModel.sortOption) {
                        Text("VIN").tag(RideViewModel.Sorting.vin)
                        Text("Car Type").tag(RideViewModel.Sorting.car_type)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                
                // List of vehicles
                List(viewModel.sortedList) { vehicle in
                    NavigationLink(destination: VehicleDetail(ride: vehicle)) {
                        VStack(alignment: .leading) {
                            Text("Make & Model: \(vehicle.make_and_model)")
                            Text("VIN: \(vehicle.vin)")
                        }
                    }
                }
                Spacer()
            }
            .padding(20)
            .navigationTitle("Vehicles")
        }
    }
}


#Preview {
    ContentView()
}
