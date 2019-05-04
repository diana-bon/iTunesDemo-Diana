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
  
  // For testing purpose.
  init() {
    let tracks = [
      TrackModel(artistId: "0", artistName: "Bob dylan", trackName: "Blabla", collectionName: "blalabla", artworkUrl100: "URL"),
      TrackModel(artistId: "1", artistName: "Bob dylan1", trackName: "Blablaaa", collectionName: "blalabla", artworkUrl100: "URL"),
      TrackModel(artistId: "2", artistName: "Bob dylan2", trackName: "Blablaaaa", collectionName: "blalabla", artworkUrl100: "URL")
    ]
    
    self.resultCount = tracks.count
    self.results = tracks
  }
}
