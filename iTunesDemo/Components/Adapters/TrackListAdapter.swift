//
//  TrackListAdapter.swift
//  iTunesDemo
//
//  Created by Anou on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

class TrackListAdapter: BaseAdapter
{
  var trackList: TrackListModel?
  
  enum Path
  {
    case trackList
    
    var url: String {
      switch self {
      case .trackList: return "search?term="
      }
    }
    
    var method: Method {
      switch self {
      case .trackList: return .GET
      }
    }
  }
}

extension TrackListAdapter: TracklistAdapting
{
  func fetchTracklist(with text: String, completion: @escaping TrackListResult) {
    let url = "\(Path.trackList.url)\(text)"
    let resource = Resource.init(path: url.toURLString(), method: Path.trackList.method)
    
    session.request(resource: resource) { result in
      switch result {
      case .success(let data):
        let decoder = JSONDecoder()
        if let jsonData = data.data(using: .utf8), let trackList = try? decoder.decode(TrackListModel.self, from: jsonData) {
          self.trackList = trackList
          completion(.success(trackList))
        } else {
          completion(.failure(.parsing))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
