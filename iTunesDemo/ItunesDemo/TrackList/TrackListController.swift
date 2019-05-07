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
  var database: DatabaseAccess
  
  enum ErrorMessage
  {
    static var common = "An error occured."
  }
  
  init(adapter: TracklistAdapting, view: TrackListControllerOutput, database: DatabaseAccess) {
    self.view = view
    self.adapter = adapter
    self.database = database
  }
  
  private func handleError(_ error: Error?) {
    view.displayError(message: error?.description ?? ErrorMessage.common)
  }
  
  private func handleTrackListSuccess(_ trackList: TrackListModel) {
    let favTracks = database.getFavouriteTracks()
    var tracks = trackList.results
    
    favTracks.forEach({ trackId in
      tracks = tracks.map { item in
        var trackItem = item
        if trackItem.trackId == trackId {
          trackItem.isFavourite = true
        }
        return trackItem
      }
    })
    
    let updatedTrackList = TrackListModel(count: trackList.resultCount, tracks: tracks)
    view.displayTrackList(trackModel: updatedTrackList)
  }
  
  private func handleAddFavouriteSuccess(trackId: Int) {
    view.displayFavouriteTrackAdded(trackId: trackId)
  }
}

extension TrackListController: TrackListControllerInput
{
  func addFavouriteTrack(trackId: Int) {
    database.saveFavouriteTrack(trackId: trackId) { [weak self] result in
      switch result {
      case .failure(let error):
        self?.handleError(error)
      case .success:
        self?.handleAddFavouriteSuccess(trackId: trackId)
      }
    }
  }
  
  func logout() {
    database.logout()
  }
  
  func findTrackList(with text: String) {
    adapter.fetchTracklist(with: text) { [weak self] result in
      switch result {
      case .success(let tracklist):
        self?.handleTrackListSuccess(tracklist)
      case .failure(let error):
        self?.handleError(error)
      }
    }
  }
}
