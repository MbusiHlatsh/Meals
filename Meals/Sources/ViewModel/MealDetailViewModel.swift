//
//  MealDetailViewModel.swift
//  Meals
//
//  Created by Mbusi Hlatshwayo - Vendor on 1/29/24.
//

import Foundation

class MealDetailViewModel {

    let apiManager = MealDetailsAPI()
    var meal: Meal?

    // MARK: Output
    @Published private(set) var title = ""
    @Published private(set) var ingredients = ""
    @Published private(set) var instructions = ""

    func getDetails() {
        apiManager.fetchData(forMealID: meal?.idMeal ?? "") { [weak self] result in
            switch result {
            case .success(let response):
                self?.convertToMeals(from: response)
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }

    func convertToMeals(from mealResponse: MealDetail) {
        let mealDetails = mealResponse.meals[0]
        title = mealDetails["strMeal"] as? String ?? ""
        var ingredientsList = ""
        for i in stride(from: 1, through: 20, by: 1) {
            if let ingredient = mealDetails["strIngredient\(i)"] as? String,
               ingredient.isEmpty == false {
                let quantity = mealDetails["strMeasure\(i)"] as? String
                ingredientsList += "\(ingredient) \(quantity ?? "")\n"
            } else {
                break
            }
        }
        ingredients = ingredientsList
        if let mealInstructions = mealDetails["strInstructions"] as? String,
           mealInstructions.isEmpty == false {
            instructions = mealInstructions
        }
    }
}
