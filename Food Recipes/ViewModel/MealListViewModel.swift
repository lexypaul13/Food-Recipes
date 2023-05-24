//
//  MealListViewModel.swift
//  Food Recipes
//
//  Created by Alex Paul on 5/24/23.
//

import Foundation

class MealListViewModel {
    private var meals: [Meal] = []
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    var count: Int {
        return meals.count
    }
    
    func mealName(at index: Int) -> String? {
        guard index >= 0 && index < count else { return nil }
        return meals[index].strMeal
    }
    
    func mealImageURL(at index: Int) -> URL? {
        guard index >= 0 && index < count else { return nil }
        return meals[index].strMealThumb
    }
    
    func mealID(at index: Int) -> String? {
        guard index >= 0 && index < count else { return nil }
        return meals[index].idMeal
    }
    
    func fetchMeals(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        networkService.fetchMealList { [weak self] result in
            switch result {
            case .success(let mealList):
                self?.meals = mealList.meals.sorted(by: { $0.strMeal < $1.strMeal })
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
