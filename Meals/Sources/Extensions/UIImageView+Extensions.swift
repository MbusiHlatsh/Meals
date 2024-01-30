//
//  UIImageView+Extensions.swift
//  Meals
//
//  Created by Mbusi Hlatshwayo - Vendor on 1/30/24.
//

import UIKit

extension UIImageView {
    func setImage(from urlString: String) {
        let placeholderImage = UIImage(named: Constants.placeholderImage)
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.image = placeholderImage
            }
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    self.image = placeholderImage
                }
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.image = placeholderImage
                }
                return
            }

            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
