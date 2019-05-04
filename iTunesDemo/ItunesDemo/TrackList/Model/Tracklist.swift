//
//  Track.swift
//  iTunesDemo
//
//  Created by Anou on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

struct TrackModel: Codable
{
  let artistId: String
  let artistName: String
  let trackName: String
  let collectionName: String
  let artworkUrl100: String
}

struct TrackListModel: Codable
{
  let resultCount: Int
  let results: [TrackModel]
}
