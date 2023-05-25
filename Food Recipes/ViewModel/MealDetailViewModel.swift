//
//  MealDetailViewModel.swift
//  Food Recipes
//
//  Created by Alex Paul on 5/24/23.
//

import Foundation
 
class MealDetailListViewModel {
    private var mealDetail: MealDetail?
    private var networkService: NetworkService
    
    var mealName: String? {
        mealDetail?.strMeal
    }
    
    var mealInstructions: String? {
        mealDetail?.strInstructions
    }
    
    var mealImage: URL? {
        mealDetail?.strMealThumb
    }
    
    var ingredientCount: Int {
        mealDetail?.ingredients.count ?? 0
    }
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func ingredientName(at index: Int) -> String? {
        guard index >= 0 && index < ingredientCount else { return nil }
        return mealDetail?.ingredients[index].name
    }
    
    func ingredientMeasure(at index: Int) -> String? {
        guard index >= 0 && index < ingredientCount else { return nil }
        return mealDetail?.ingredients[index].measure
    }
    
    func fetchMealDetails(mealID: String, completion: @escaping (Bool) -> Void) {
        networkService.fetchMealDetails(mealID: mealID) { [weak self] result in
            switch result {
            case .success(let mealDetailsList):
                self?.mealDetail = mealDetailsList.meals.first
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
    
}
