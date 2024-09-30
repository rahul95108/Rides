//
//  RideViewModel.swift
//  Rides
//
//  Created by Rahulkumar Patel on 2024-09-28.
//

import Foundation
import SwiftUI

class RideViewModel: ObservableObject {
    @Published var vehicles: [Ride] = []
    @Published var vehicleNumber: String = ""
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String = ""
    @Published var sortOption: Sorting = .vin
    
    // MARK: - Sorting the List -
    
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

    // MARK: - Fetch Vehicle List Using API -
    
    func fetchVehicles() {
        guard isValidInput(vehicleNumber) else { return }
        
        // Load API URL from Config.plist
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let apiURL = dict["API_URL"] as? String {
            let apiEndpoint = apiURL + "size=\(vehicleNumber)"
            loadVehicles(from: apiEndpoint)
        } else {
            errorMessage = "API URL Not Found."
            showAlert = true
        }
    }
    
    private func loadVehicles(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        isLoading = true
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let data = data {
                    do {
                        let vehicles = try JSONDecoder().decode([Ride].self, from: data)
                        self?.vehicles = vehicles
                    } catch {
                        self?.errorMessage = "Failed to decode vehicle data."
                        self?.showAlert = true
                    }
                } else if let error = error {
                    self?.errorMessage = "Error fetching data: \(error.localizedDescription)"
                    self?.showAlert = true
                }
            }
        }.resume()
    }
    
    // MARK: - Input Validation Logic -
    
    func isValidInput(_ input: String) -> Bool {
        if let count = Int(input), count >= 1 && count <= 100 {
            showAlert = false
            errorMessage = ""
            return true
        }
        errorMessage = "Please enter a number between 1 and 100."
        showAlert = true
        return false
    }
    
    // MARK: - Dismiss Keyboard -
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
