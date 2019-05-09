//
//  Collection+extensions.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 05/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

extension Collection {
  
  /// Returns the element at the specified index if it is within bounds, otherwise nil.
  subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
