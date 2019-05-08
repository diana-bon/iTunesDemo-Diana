//
//  TrackListController.swift
//  iTunesDemo
//
//  Created by Anou on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

class TrackListController: DatabaseInjector
{
  var view: TrackListControllerOutput
  var adapter: TracklistAdapting
  
  enum ErrorMessage
  {
    static var common = "An error occured."
  }
  
  init(adapter: TracklistAdapting, view: TrackListControllerOutput) {
    self.view = view
    self.adapter = adapter
  }
  
  private func handleError(_ error: Error?) {
    view.displayError(message: error?.description ?? ErrorMessage.common)
  }
  
  private func handleTrackListSuccess(_ trackList: TrackListModel) {
    let favTracks = database.favouriteTracks
    
    var tracks = trackList.results
    
    favTracks.forEach({ favTrack in
      tracks = tracks.map { item in
        var trackItem = item
        if trackItem.trackId == favTrack.trackId {
          trackItem.isFavourite = true
        }
        return trackItem
      }
    })
    
    adapter.trackList?.results = tracks
    let updatedTrackList = TrackListModel(count: trackList.resultCount, tracks: tracks)
    view.displayTrackList(trackModel: updatedTrackList)
  }
  
  private func handleToggleFavouriteSuccess(trackId: Int) {
    view.displayFavouriteTrackToggled(trackId: trackId)
  }
}

extension TrackListController: TrackListControllerInput
{
  func getFavouriteTracks() {
    database.getFavouriteTracks()
  }
  
  func toggleFavouriteTrack(trackId: Int) {
    guard let track = adapter.trackList?.results.filter({ $0.trackId == trackId }).first else { return }
    
    if track.isFavourite {
      database.removeFavouriteTrack(trackId: trackId) { [weak self] result in
        switch result {
        case .failure(let error):
          self?.handleError(error)
        case .success:
          self?.handleToggleFavouriteSuccess(trackId: trackId)
        }
      }
    } else {
      database.saveFavouriteTrack(trackId: trackId) { [weak self] result in
        switch result {
        case .failure(let error):
          self?.handleError(error)
        case .success:
          self?.handleToggleFavouriteSuccess(trackId: trackId)
        }
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
