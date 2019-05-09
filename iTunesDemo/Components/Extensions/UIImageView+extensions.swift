//
//  UIImageView+extensions.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 05/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation
import UIKit

private let imageCache = NSCache<NSString, UIImage>()

extension UIImageView
{
  func imageFromServerURL(_ url: URL?, placeHolder: UIImage? = nil) {
    self.image = nil
    guard let url = url else { return }
    
    if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
      self.image = cachedImage
      return
    }
    
    URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      if error != nil {
        DispatchQueue.main.async {
          self.image = placeHolder
        }
        return
      }
      DispatchQueue.main.async {
        if let data = data {
          if let downloadedImage = UIImage(data: data) {
            imageCache.setObject(downloadedImage, forKey: NSString(string: url.absoluteString))
            self.image = downloadedImage
            return
          }
        }
      }
    }).resume()
  }
}
