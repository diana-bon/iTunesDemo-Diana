//
//  Track.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

struct TrackModel: Codable
{
  let artistId: Int?
  let trackId: Int?
  let artistName: String?
  let trackName: String?
  let collectionName: String?
  let artworkUrl100: String?
  
  var isFavourite: Bool = false
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    artistId = try container.decodeIfPresent(Int.self, forKey: .artistId)
    trackId = try container.decodeIfPresent(Int.self, forKey: .trackId)
    artistName = try container.decodeIfPresent(String.self, forKey: .artistName)
    trackName = try container.decodeIfPresent(String.self, forKey: .trackName)
    collectionName = try container.decodeIfPresent(String.self, forKey: .collectionName)
    artworkUrl100 = try container.decodeIfPresent(String.self, forKey: .artworkUrl100)
  }
}

struct TrackListModel: Codable
{
  let resultCount: Int
  var results: [TrackModel] = []
  
  init(count: Int, tracks: [TrackModel]) {
    self.resultCount = count
    self.results = tracks
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    resultCount = try container.decode(Int.self, forKey: .resultCount)
    results = try container.decode([TrackModel].self, forKey: .results)
  }
}
