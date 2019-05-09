//
//  TrackListCell.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation
import UIKit

protocol TrackListCellDelegate: class
{
  func didFavouriteTrack(trackId: Int)
}

class TrackListCell: UITableViewCell
{
  @IBOutlet private weak var trackImageView: UIImageView?
  @IBOutlet private weak var titleLabel: UILabel?
  @IBOutlet private weak var descriptionLabel: UILabel?
  @IBOutlet private weak var favouriteIconView: UIView?
  @IBOutlet private weak var favouriteIcon: UIImageView?
  
  weak var delegate: TrackListCellDelegate?
  
  var trackId: Int?
  
  enum CellValue
  {
    static let favouriteIcon = "favouriteIcon"
    static let notFavouriteIcon = "notFavouriteIcon"
  }
  
  func setup(model: TrackModel?) {
    titleLabel?.text = model?.trackName
    
    let description = "\(model?.artistName ?? "-") - \(model?.collectionName ?? "-")"
    descriptionLabel?.text = description
    
    if let url = model?.artworkUrl100 {
      trackImageView?.imageFromServerURL(URL(string: url), placeHolder: UIImage(named: "defaultIcon"))
    }
    
    self.trackId = model?.trackId
    
    var imageName = CellValue.notFavouriteIcon
    imageName = model?.isFavourite ?? false ? CellValue.favouriteIcon : imageName
    favouriteIcon?.image = UIImage(named: imageName)
    
    addFavouriteGesture()
  }
  
    private func addFavouriteGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFavouriteIcon))
    favouriteIconView?.addGestureRecognizer(tapGesture)
  }
  
  @objc func didTapFavouriteIcon() {
    guard let id = trackId else { return }
    delegate?.didFavouriteTrack(trackId: id)
  }
}
