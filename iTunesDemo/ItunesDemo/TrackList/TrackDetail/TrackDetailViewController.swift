//
//  TrackDetailViewController.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 07/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation
import UIKit

class TrackDetailViewController: UIViewController
{
  @IBOutlet private weak var trackImageView: UIImageView?
  @IBOutlet private weak var artistNameLabel: UILabel?
  @IBOutlet private weak var collectionNameLabel: UILabel?
  @IBOutlet private weak var trackNameLabel: UILabel?
  
  var track: TrackModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Track Detail"
    self.setup(viewModel: track)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationItem.hidesBackButton = false
  }
  
  private func setup(viewModel: TrackModel?) {
    trackNameLabel?.text = viewModel?.trackName
    artistNameLabel?.text = viewModel?.artistName
    collectionNameLabel?.text = viewModel?.collectionName

    if let url = viewModel?.artworkUrl100 {
      trackImageView?.imageFromServerURL(URL(string: url), placeHolder: UIImage(named: "defaultIcon"))
    }
  }
}
