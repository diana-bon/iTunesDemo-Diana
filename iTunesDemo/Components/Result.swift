//
//  Result.swift
//  iTunesDemo
//
//  Created by Anou on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

enum Result<T, E>
{
  case success(T)
  case failure(E)
}
