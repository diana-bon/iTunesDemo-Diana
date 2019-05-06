//
//  String+extensions.swift
//  iTunesDemo
//
//  Created by Anou on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

extension String
{
  func toURLString() -> String {
    let clean = self.replacingOccurrences(of: " ", with: "+")
    return clean
  }
}
