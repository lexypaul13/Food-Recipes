//
//  MealList.swift
//  Food Recipes
//
//  Created by Alex Paul on 5/23/23.
//

import Foundation

struct MealList: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: URL
    let idMeal: String
}
