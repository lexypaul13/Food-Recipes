//
//  ImageCache.swift
//  Food Recipes
//
//  Created by Alex Paul on 5/24/23.
//

import UIKit

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        self.image = nil
        
         if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
         guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
             if let error = error {
                print("Failed downloading image: ", error)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                imageCache.setObject(image, forKey: urlString as NSString)
                self?.image = image
            }
        }.resume()
    }
}

