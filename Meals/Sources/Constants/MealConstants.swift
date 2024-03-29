//
//  MealConstants.swift
//  Meals
//
//  Created by Mbusi Hlatshwayo - Vendor on 1/30/24.
//

import Foundation

struct Constants {
    // Network layer constants
    static let dessertEndpoint = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    static let mealEndpoint = "https://themealdb.com/api/json/v1/1/lookup.php?i="

    // View layer constants
    static let mealViewTitle = "Desserts"
    static let genericErrorMessage = "Sorry there was an issue"
    static let genericErrorDismissMessage = "OK"
    static let placeholderImage = "placeholderImage"
    static let mealCollectionViewCellID = "MealCollectionViewCell"
    static let invalidURLMessage = "Invalid URL"
    
    // Model layer constants
    static let mealDetailsTitleKey = "strMeal"
    static let mealDetailsIngredientKey = "strIngredient"
    static let mealDetailsMeasurementKey = "strMeasure"
    static let mealDetailsInstructionsKey = "strInstructions"
}
