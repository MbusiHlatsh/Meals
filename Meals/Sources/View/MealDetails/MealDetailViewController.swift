//
//  MealDetailViewController.swift
//  Meals
//
//  Created by Mbusi Hlatshwayo - Vendor on 1/28/24.
//

import Combine
import UIKit

class MealDetailViewController: UIViewController {

    var viewModel: MealDetailViewModel?
    private var subscriptions = Set<AnyCancellable>()

    lazy var mealNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
        configureSubscribers()
        
        viewModel?.getDetails()
    }

    private func configureView() {
        // we need the scroll view for tall content that does not fit
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        // stack view to hold labels for meal name, ingredients, instructions, etc.
        let stackView = UIStackView(arrangedSubviews: [mealNameLabel, ingredientsLabel, instructionsLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        // set up constraints
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }

    /// bind the labels to the view model subscriber
    private func configureSubscribers() {
        viewModel?.$title.sink(receiveValue: { value in
            DispatchQueue.main.async {
                self.mealNameLabel.text = value
            }
        }).store(in: &subscriptions)
        viewModel?.$ingredients.sink(receiveValue: { value in
            DispatchQueue.main.async {
                self.ingredientsLabel.text = value
            }
        })
        .store(in: &subscriptions)
        viewModel?.$instructions.sink(receiveValue: { value in
            DispatchQueue.main.async {
                self.instructionsLabel.text = value
            }
        })
        .store(in: &subscriptions)
    }
}
