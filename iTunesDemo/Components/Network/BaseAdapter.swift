//
//  BaseAdapter.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

protocol NetworkAdapting
{
  var baseURL: String { get set }
  var session: Networkable { get set }
}

class BaseAdapter: NetworkAdapting
{
  var baseURL: String = "https://itunes.apple.com/"
  var session: Networkable
  
  init() {
    let url = URL(string: baseURL)!
    self.session = Network(baseURL: url)
  }
}
