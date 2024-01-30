//
//  Meal.swift
//  Meals
//
//  Created by Mbusi Hlatshwayo - Vendor on 1/28/24.
//

import Foundation

struct MealResponse: Codable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct MealDetail: Codable {
    let meals: [[String: String?]]
}
