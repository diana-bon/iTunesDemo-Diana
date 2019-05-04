//
//  TrackListCell.swift
//  iTunesDemo
//
//  Created by Anou on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation
import UIKit

class TrackListCell: UITableViewCell
{
  @IBOutlet private weak var artistImageView: UIImageView?
  @IBOutlet private weak var artistNameLabel: UILabel?
  @IBOutlet private weak var trackNameLabel: UILabel?
  
  var artistName: String? {
    didSet {
      artistNameLabel?.text = artistName
    }
  }
  
  var trackName: String? {
    didSet {
      trackNameLabel?.text = trackName
    }
  }
  
  var artistImage: UIImage? {
    didSet {
      artistImageView?.image = artistImage
    }
  }
}
