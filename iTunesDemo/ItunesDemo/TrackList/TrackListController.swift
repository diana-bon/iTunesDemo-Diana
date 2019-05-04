//
//  TrackListController.swift
//  iTunesDemo
//
//  Created by Anou on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

class TrackListController
{
  var view: TrackListControllerOutput
  var session: Network
  
  enum Path
  {
    case trackList

    var url: String {
      switch self {
      case .trackList: return "search?term="
      }
    }
  }
  
  init(view: TrackListControllerOutput) {
    self.view = view
    self.session = Network(baseURL: URL(string: "https://itunes.apple.com/")!)
  }
}

extension TrackListController: TrackListControllerInput
{
  func findTrackList(with artist: String) {
    let resource = Resource.init(path: Path.trackList.url, method: .GET)
    
    session.request(resource: resource) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let data):
        let decoder = JSONDecoder()
        let trackList = try! decoder.decode(TrackListModel.self, from: data)
        self.view.displayTrackList(trackModel: trackList)
      case .failure(let error):
        self.view.displayError(message: error.localizedDescription)
      }
    }
  }
}
