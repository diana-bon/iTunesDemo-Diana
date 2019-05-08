//
//  FirebaseManager.swift
//  iTunesDemo
//
//  Created by Anou on 07/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

typealias DatabaseResult = (Result<User, Error?>) -> Void
typealias TracksResult = (Result<[Int]?, Error?>) -> Void

protocol DatabaseAccess
{
  func createAccount(login: String, password: String, completion: @escaping DatabaseResult)
  func login(login: String, password: String, completion: @escaping DatabaseResult)
  func logout()
  func saveFavouriteTrack(trackId: Int, completion: @escaping TracksResult)
  func removeFavouriteTrack(trackId: Int, completion: @escaping TracksResult)
  func getFavouriteTracks()
  
  var favouriteTracks: [FavouriteTrackItem] { get set }
}

protocol DatabaseInjector
{
  var database: DatabaseAccess { get }
}

extension DatabaseInjector
{
  var database: DatabaseAccess {
    return sharedFirebaseManager
  }
}

fileprivate let sharedFirebaseManager = FirebaseManager()

final class FirebaseManager: DatabaseAccess
{
  let ref = Database.database().reference()
  
  var favouriteTracks: [FavouriteTrackItem] = []
  
  enum FirebaseKeys
  {
    static let favouriteTracks = "favourite-tracks"
  }
  
  var currentUser: User?
  
  func createAccount(login: String, password: String, completion: @escaping DatabaseResult) {
    Auth.auth().createUser(withEmail: login, password: password) { [weak self] user, error in
      if error != nil {
        completion(.failure(.database))
        return
      }
      
      // Sign in if success
      self?.login(login: login, password: password) { result in
        switch result {
        case .failure(let error):
          completion(.failure(error))
        case .success(let user):
          completion(.success(user))
        }
      }
    }
  }
  
  func login(login: String, password: String, completion: @escaping DatabaseResult) {
    Auth.auth().signIn(withEmail: login, password: password) { [weak self] user, error in
      if error != nil {
        completion(.failure(.database))
        return
      }
      
      self?.currentUser = user?.user
      
      if let usr = user {
        completion(.success(usr.user))
      } else {
        completion(.failure(.database))
      }
    }
  }
  
  func logout() {
    do {
      self.currentUser = nil
      self.favouriteTracks = []
      try Auth.auth().signOut()
    } catch let err {
      // TODO: show error if logout fail
    }
  }
  
  func saveFavouriteTrack(trackId: Int, completion: @escaping TracksResult) {
    guard let user = self.currentUser else {
      completion(.failure(.database))
      return
    }
    
    let favRef = self.ref.child(FirebaseKeys.favouriteTracks)
    let userRef = favRef.child(user.uid)
    let favItem = FavouriteTrackItem(trackId: trackId)
    
    userRef.childByAutoId().setValue(favItem.toAnyObject())
    self.favouriteTracks.append(favItem)
    completion(.success([trackId]))
  }
  
  func removeFavouriteTrack(trackId: Int, completion: @escaping TracksResult) {
    guard let user = self.currentUser else {
      completion(.failure(.database))
      return
    }
    
    let favRef = self.ref.child(FirebaseKeys.favouriteTracks)
    let userRef = favRef.child(user.uid)
    
    userRef.observe(.value) { [weak self] snapshot in
      guard let self = self else { return }
      for child in snapshot.children {
        guard let data = child as? DataSnapshot, let dict = data.value as? [String: Any] else { return }
        if let favTrackId = dict["trackId"] as? Int {
          if favTrackId == trackId {
            userRef.child(data.key).removeValue()
            let filter = self.favouriteTracks.filter({ $0.trackId != trackId })
            self.favouriteTracks = filter
            completion(.success([trackId]))
          }
        }
      }
    }
  }
  
  func getFavouriteTracks() {
    guard let user = currentUser else { return }
    let favRef = self.ref.child(FirebaseKeys.favouriteTracks)
    let userRef = favRef.child(user.uid)
    
    userRef.observe(.value) { [weak self] snapshot in
      for child in snapshot.children {
        guard let data = child as? DataSnapshot, let dict = data.value as? [String: Any] else { return }
        if let trackId = dict["trackId"] as? Int {
          let favTrack = FavouriteTrackItem(trackId: trackId)
          self?.favouriteTracks.append(favTrack)
        }
      }
    }
  }
}

