//
//  TrackListBoundaries.swift
//  iTunesDemo
//
//  Created by Anou on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

protocol TrackListControllerInput
{
  func findTrackList(with text: String)
  func logout()
  func toggleFavouriteTrack(trackId: Int)
  func getFavouriteTracks()
}

protocol TrackListControllerOutput
{
  func displayFavouriteTrackToggled(trackId: Int)
  func displayTrackList(trackModel: TrackListModel)
  func displayError(message: String)
}

typealias TrackListResult = (Result<TrackListModel, Error>) -> Void

protocol TracklistAdapting
{
  func fetchTracklist(with text: String, completion: @escaping TrackListResult)
  
  var trackList: TrackListModel? { get set }
}
