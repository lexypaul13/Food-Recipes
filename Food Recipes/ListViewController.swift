//
//  ListViewController.swift
//  Food Recipes
//
//  Created by Alex Paul on 5/23/23.
//

import UIKit

class ListViewController: UIViewController {
    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMealDetails(mealID: "53049")
    }
    
    func fetchMealList() {
         networkService.fetchMealList { result in
             switch result {
             case .success(let mealList):
                 // TODO: Use this data to update your user interface
                 print(mealList.meals)
             case .failure(let error):
                 print("Error: \(error.rawValue)")
             }
         }
     }

     func fetchMealDetails(mealID: String) {
         networkService.fetchMealDetails(mealID: "52923") { result in
                  switch result {
                  case .success(let mealDetailsList):
                      guard let mealDetail = mealDetailsList.meals.first else { return }
                      print("Meal Detail: \(mealDetail)")
                  case .failure(let error):
                      print("Error occurred: \(error)")
                  }
              }
     }
}
