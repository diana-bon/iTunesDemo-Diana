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
  case network(description: String)
  case parsing
}
