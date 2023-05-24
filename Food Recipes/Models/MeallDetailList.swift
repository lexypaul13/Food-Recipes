//
//  MeallDetailList.swift
//  Food Recipes
//
//  Created by Alex Paul on 5/23/23.
//

import Foundation
struct MealDetailsList: Codable {
    let meals: [MealDetail]
}

struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: URL
    let ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(URL.self, forKey: .strMealThumb)
        
        var ingredients: [Ingredient] = []
        for i in 1...20 {
            let ingredientKey = "strIngredient\(i)"
            let measureKey = "strMeasure\(i)"
            
            if let ingredientKey = CodingKeys(rawValue: ingredientKey),
               let measureKey = CodingKeys(rawValue: measureKey),
               let ingredient = try? container.decodeIfPresent(String.self, forKey: ingredientKey),
               let measure = try? container.decodeIfPresent(String.self, forKey: measureKey),
               ingredient.isEmpty,
               measure.isEmpty {
                
                ingredients.append(Ingredient(name: ingredient, measure: measure))
            }
        }
        self.ingredients = ingredients
    }

}

struct Ingredient: Codable {
    let name: String
    let measure: String
}
