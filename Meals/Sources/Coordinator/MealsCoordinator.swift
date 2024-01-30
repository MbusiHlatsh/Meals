//
//  MealsCoordinator.swift
//  Meals
//
//  Created by Mbusi Hlatshwayo - Vendor on 1/28/24.
//

import Foundation
import UIKit
import Combine

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start(windowScene: UIWindowScene)
    func showDetailView(with meal: Meal)
}

class MealsCoordinator: Coordinator {

    private var window = UIWindow(frame: UIScreen.main.bounds)
    
    var navigationController = UINavigationController()
    var mealListViewController: MealListCollectionViewController!

    func start(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        mealListViewController = MealListCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigation = UINavigationController(rootViewController: mealListViewController)
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
        let mealViewModel = MealListViewModel()
        mealListViewController.viewModel = mealViewModel
        mealListViewController.mealCoordinator = self
    }

    func showDetailView(with meal: Meal) {
        let mealDetailView = MealDetailViewController()
        let mealDetailViewModel = MealDetailViewModel()
        mealDetailViewModel.meal = meal
        mealDetailView.viewModel = mealDetailViewModel
        self.mealListViewController.navigationController?.pushViewController(mealDetailView, animated: true)
    }
}
