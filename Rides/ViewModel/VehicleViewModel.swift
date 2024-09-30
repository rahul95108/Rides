//
//  VehicleViewModel.swift
//  Rides
//
//  Created by Rahulkumar Patel on 2024-09-27.
//

import SwiftUI
import Combine

class VehicleViewModel: ObservableObject {
    @Published var vehicleNumber = ""
    @Published var isLoading = false
    @Published var vehicles: [Ride] = []
    @Published var sortOption: Sorting = .vin
    @Published var errorMessage = ""
    
    // MARK: - Data Sorting -
    enum Sorting {
        case vin, car_type
    }
    
    var sortedList: [Ride] {
        switch sortOption {
        case .vin:
            return vehicles.sorted { $0.vin < $1.vin }
        case .car_type:
            return vehicles.sorted { $0.car_type < $1.car_type }
        }
    }
    
    // MARK: - Fetch Data from API -
    
    func fetchAPIURL() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let apiURL = dict["API_URL"] as? String {
            fetchVehicleList(strAPI: apiURL)
        } else {
            print("API URL Not Found.")
        }
    }
    
    func fetchVehicleList(strAPI: String) {
        guard let count = Int(vehicleNumber), isValidInput(vehicleNumber) else {
            errorMessage = "Invalid Input"
            return
        }
        errorMessage = ""
        
        let apiURL = strAPI + "size=\(count)"
        isLoading = true
        
        guard let urlRequest = URL(string: apiURL) else { return }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let data = data {
                    do {
                        let vehicleList = try JSONDecoder().decode([Ride].self, from: data)
                        self.vehicles = vehicleList
                    } catch {
                        self.errorMessage = "Vehicle Loading Error: \(error)"
                    }
                }
            }
        }.resume()
    }
    
    // MARK: - Input Value Validation -
    
    func isValidInput(_ input: String) -> Bool {
        if let count = Int(vehicleNumber), count >= 1 && count <= 100 {
            return true
        }
        return false
    }
    
    // MARK: - Dismiss Keyboard -
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
