//
//  MealCollectionViewCell.swift
//  Meals
//
//  Created by Mbusi Hlatshwayo - Vendor on 1/28/24.
//

import UIKit

class MealCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "MealCollectionViewCell"

    // Image view to display an image
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Label to display text
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add subviews
        addSubview(imageView)
        addSubview(titleLabel)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0),
            
            titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Function to configure the cell with data
    func configure(with imageURL: String, title: String) {
        // Set image and title
//        imageView.image = UIImage(named: imageName)
        imageView.setImage(from: imageURL)
        titleLabel.text = title
    }
}

extension UIImageView {
    func setImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching image: \(error)")
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid data or unable to create UIImage")
                return
            }

            // Update the UI on the main thread
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
