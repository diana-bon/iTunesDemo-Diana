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
  var adapter: TracklistAdapting
  
  enum ErrorMessage
  {
    static var network = "The tracklist couldnt be fetched."
  }
  
  init(adapter: TracklistAdapting, view: TrackListControllerOutput) {
    self.view = view
    self.adapter = adapter
  }
}

extension TrackListController: TrackListControllerInput
{
  func findTrackList(with text: String) {
    adapter.fetchTracklist(with: text) { [weak self] result in
      switch result {
      case .success(let tracklist):
        self?.view.displayTrackList(trackModel: tracklist)
      case .failure(let error):
        self?.view.displayError(message: error.description)
      }
    }
  }
}
