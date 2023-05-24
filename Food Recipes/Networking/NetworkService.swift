//
//  NetworkService.swift
//  Food Recipes
//
//  Created by Alex Paul on 5/23/23.
//

import Foundation
class NetworkService {
    private let networkManager: Networking

    init(networkManager: Networking = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchMealList(completion: @escaping (Result<MealList, NetworkError>) -> Void) {
        networkManager.fetch(endpoint: .mealList(category: "Dessert")) { (result: Result<MealList, NetworkError>) in
            completion(result)
        }
    }

    func fetchMealDetails(mealID: String, completion: @escaping (Result<MealDetailsList, NetworkError>) -> Void) {
        networkManager.fetch(endpoint: .mealDetails(mealID: mealID)) { (result: Result<MealDetailsList, NetworkError>) in
            completion(result)
        }
    }
}
