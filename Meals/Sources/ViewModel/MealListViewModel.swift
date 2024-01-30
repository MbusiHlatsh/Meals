//
//  MealListViewModel.swift
//  Meals
//
//  Created by Mbusi Hlatshwayo - Vendor on 1/28/24.
//

import Foundation
import Combine

class MealListViewModel {

    let apiManager = MealsListAPI()
    var meals: [Meal]?

    private var eventSubject = PassthroughSubject<[Meal], NetworkError>()
    var eventPublisher: AnyPublisher<[Meal], NetworkError> {
        return eventSubject.eraseToAnyPublisher()
    }
    
    func getMeals() {
        apiManager.fetchData { [weak self] result in
            switch result {
            case .success(let response):
                let sortedResponse = response.meals.sorted {
                    $0.strMeal < $1.strMeal
                }
                self?.meals = sortedResponse
                self?.eventSubject.send(sortedResponse)
            case .failure(let error):
                self?.eventSubject.send(completion: .failure(error))
            }
        }
    }
}
