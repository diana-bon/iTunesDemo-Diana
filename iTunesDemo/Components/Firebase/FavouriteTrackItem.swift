//
//  FavouriteTrackItem.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 08/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

struct FavouriteTrackItem
{
  var trackId: Int
  
  init(trackId: Int) {
    self.trackId = trackId
  }
  
  func toAnyObject() -> Any {
    return [
      "trackId": trackId
    ]
  }
}


