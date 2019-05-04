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
  func findTrackList(with artist: String)
}

protocol TrackListControllerOutput
{
  func displayTrackList(trackModel: TrackListModel)
  func displayError(message: String)
}
