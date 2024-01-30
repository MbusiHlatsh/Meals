//
//  MealListCollectionViewController.swift
//  Meals
//
//  Created by Mbusi Hlatshwayo - Vendor on 1/28/24.
//

// YourCollectionViewController.swift

import UIKit
import Combine
class MealListCollectionViewController: UICollectionViewController {

    var viewModel: MealListViewModel?
    private var subscribers: [AnyCancellable] = []
    public var mealCoordinator: Coordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.mealViewTitle
        collectionView.register(MealCollectionViewCell.self, forCellWithReuseIdentifier: MealCollectionViewCell.reuseIdentifier)
        collectionView.collectionViewLayout = createLayout()
        viewModel?.eventPublisher
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.presentErrorAlert(
                        title: Constants.genericErrorMessage,
                        message: error.localizedDescription
                    )
                }
            }, receiveValue: { [weak self] meals in
                self?.resetView()
            })
            .store(in: &subscribers)
        viewModel?.getMeals()
    }

    private func resetView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    private func presentErrorAlert(
        title: String,
        message: String
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.genericErrorDismissMessage, style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.meals?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealCollectionViewCell.reuseIdentifier, for: indexPath) as? MealCollectionViewCell else {
            fatalError("Unable to dequeue MealCollectionViewCell")
        }

        let meal = viewModel?.meals?[indexPath.item]
        cell.configure(with: meal?.strMealThumb ?? "", title: meal?.strMeal ?? "")

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let meal = viewModel?.meals?[indexPath.item] else { return }
        mealCoordinator.showDetailView(with: meal)
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 120) // Adjust the item size as needed
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        return layout
    }
}
