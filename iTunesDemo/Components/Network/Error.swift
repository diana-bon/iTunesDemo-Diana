//
//  Error.swift
//  iTunesDemo
//
//  Created by Anou on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

enum Error: Swift.Error
{
  case network
  case parsing
  case database
  
  var description: String {
    switch self {
    case .network: return "Network error"
    case .parsing: return "Parsing error"
    case .database: return "Database error"
    }
  }
}
