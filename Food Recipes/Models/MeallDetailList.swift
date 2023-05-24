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

private struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        return nil
        
    }
}

struct Ingredient: Codable {
    let name: String
    let measure: String
}


struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: URL
    let ingredients: [Ingredient]
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        idMeal = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "idMeal")!)
        strMeal = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "strMeal")!)
        strInstructions = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: "strInstructions")!)
        strMealThumb = try container.decode(URL.self, forKey: DynamicCodingKeys(stringValue: "strMealThumb")!)
        
        var ingredients: [Ingredient] = []
        for i in 1...20 {
            let ingredientKey = "strIngredient\(i)"
            let measureKey = "strMeasure\(i)"
            
            if let ingredient = try? container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: ingredientKey)!),
               let measure = try? container.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: measureKey)!),
               
                !ingredient.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty,
               !measure.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty {
                
                ingredients.append(Ingredient(name: ingredient, measure: measure))
            }
        }
        self.ingredients = ingredients
    }
}



