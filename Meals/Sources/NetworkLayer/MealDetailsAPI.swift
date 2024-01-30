//
//  MealDetailsAPI.swift
//  Meals
//
//  Created by Mbusi Hlatshwayo - Vendor on 1/29/24.
//

import Foundation

final class MealDetailsAPI {
    func fetchData(forMealID: String, completion: @escaping (Result<MealDetail, NetworkError>) -> Void) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(forMealID)") else {
            completion(.failure(.invalidURL))
            return
        }

        NetworkManager.shared.request(url: url) { (result: Result<MealDetail, NetworkError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
