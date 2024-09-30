//
//  ContentView.swift
//  Rides
//
//  Created by Rahulkumar Patel on 2024-09-27.
//

import SwiftUI

// Dismiss keyboard 

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
    
    @StateObject private var viewModel = VehicleViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter Number of Vehicles", text: $viewModel.vehicleNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                Button(action: {
                    viewModel.vehicles = []
                    viewModel.sortOption = .vin
                    viewModel.fetchAPIURL()
                    viewModel.dismissKeyboard()
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
                
                if viewModel.isLoading {
                    ProgressView("Vehicle Loading..")
                }
                
                if viewModel.sortedList.count > 0 {
                    Picker("Sort by", selection: $viewModel.sortOption) {
                        Text("VIN").tag(VehicleViewModel.Sorting.vin)
                        Text("Car Type").tag(VehicleViewModel.Sorting.car_type)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                
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
