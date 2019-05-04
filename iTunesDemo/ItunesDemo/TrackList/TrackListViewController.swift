//
//  TrackListViewController.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 21/04/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import UIKit

class TrackListViewController: UIViewController
{
  // MARK: - Attributes
  var controller: TrackListControllerInput?
  
  var trackList: [TrackModel]?
  var trackCount: Int = 0
  
  // MARK: - Outlets
  @IBOutlet private weak var searchBar: UISearchBar?
  @IBOutlet private weak var tableView: UITableView?
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    controller = TrackListFactory.createTrackListModule(view: self)
  }
}

// MARK: - Tracklist output
extension TrackListViewController: TrackListControllerOutput
{
  func displayTrackList(trackModel: TrackListModel) {
    trackCount = trackModel.resultCount
    trackList = trackModel.results
    
    DispatchQueue.main.async {
      self.tableView?.reloadData()
    }
  }
  
  func displayError(message: String) {
    print(message)
  }
  
  private func downloadImage(_ image: String?) -> UIImage {
    // TODO: Download image
    return UIImage()
  }
}

// MARK: - Tableview delegate & datasource
extension TrackListViewController: UITableViewDataSource
{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return trackCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackListCell") as? TrackListCell else { return UITableViewCell() }
    
    let model = trackList?[indexPath.row]
    
    cell.artistName = model?.artistName
    cell.trackName = model?.trackName
    cell.artistImage = downloadImage(model?.artworkUrl100)

    return cell
  }
}

extension TrackListViewController: UITableViewDelegate
{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO
  }
}

// MARK: - Searchbar delegate
extension TrackListViewController: UISearchBarDelegate
{
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let text = searchBar.text else { return }
    controller?.findTrackList(with: text)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    tableView?.reloadData()
  }
}
