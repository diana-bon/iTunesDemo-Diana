//
//  TrackListFactory.swift
//  iTunesDemo
//
//  Created by Anou on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

enum TrackListFactory
{
  static func createTrackListModule(view: TrackListControllerOutput) -> TrackListControllerInput {
    let controller = TrackListController(view: view)
    return controller
  }
}
