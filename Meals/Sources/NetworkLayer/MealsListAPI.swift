//
//  MealsListAPI.swift
//  Meals
//
//  Created by Mbusi Hlatshwayo - Vendor on 1/29/24.
//

import Foundation

final class MealsListAPI {
    func fetchData(completion: @escaping (Result<MealResponse, NetworkError>) -> Void) {
        guard let url = URL(string: Constants.dessertEndpoint) else {
            completion(.failure(.invalidURL))
            return
        }

        NetworkManager.shared.request(url: url) { (result: Result<MealResponse, NetworkError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
