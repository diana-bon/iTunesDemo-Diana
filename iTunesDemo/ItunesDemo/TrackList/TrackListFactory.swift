//
//  TrackListFactory.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

enum TrackListFactory
{
  static func createTrackListModule(view: TrackListControllerOutput) -> TrackListControllerInput {
    let adapter = TrackListAdapter()
    let controller = TrackListController(adapter: adapter, view: view)
    return controller
  }
}
