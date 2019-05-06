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
  var trackCount: Int?
  
  // MARK: - Outlets
  @IBOutlet private weak var searchBar: UISearchBar?
  @IBOutlet private weak var tableView: UITableView?
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    controller = TrackListFactory.createTrackListModule(view: self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.isNavigationBarHidden = false
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
}

// MARK: - Tableview delegate & datasource
extension TrackListViewController: UITableViewDataSource
{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 65
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return trackCount ?? trackList?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackListCell") as? TrackListCell else { return UITableViewCell() }
    
    let model = trackList?[safe: indexPath.row]
    
    cell.titleStr = model?.trackName ?? "-"
    let description = "\(model?.artistName ?? "-") - \(model?.collectionName ?? "-")"
    cell.descriptionStr = description
    cell.trackImage = model?.artworkUrl100

    return cell
  }
}

extension TrackListViewController: UITableViewDelegate
{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    searchBar?.resignFirstResponder()
  }
}

// MARK: - Searchbar delegate
extension TrackListViewController: UISearchBarDelegate
{
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let text = searchBar.text else { return }
    if text != "" && text.count >= 3 {
      controller?.findTrackList(with: text.lowercased())
    }
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText != "" && searchText.count >= 3 {
      controller?.findTrackList(with: searchText.lowercased())
    }
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}
