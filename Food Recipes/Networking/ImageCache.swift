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
    func loadImageUsingCache(withUrl url: URL) {
        self.image = nil

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    self.image = image
                }
            }
        }).resume()
    }

}

