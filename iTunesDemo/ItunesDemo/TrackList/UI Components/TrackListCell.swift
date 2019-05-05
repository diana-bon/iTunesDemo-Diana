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
  @IBOutlet private weak var trackImageView: UIImageView?
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var descriptionLabel: UILabel?
  
  var titleStr: String? {
    didSet {
      titleLabel?.text = titleStr
    }
  }
  
  var descriptionStr: String? {
    didSet {
      descriptionLabel?.text = descriptionStr
    }
  }
  
  var trackImage: String? {
    didSet {
      if let url = trackImage {
        trackImageView?.imageFromServerURL(URL(string: url), placeHolder: UIImage(named: "defaultIcon"))
      }
    }
  }
}
