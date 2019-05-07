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

protocol DatabaseAccess
{
  func createAccount(login: String, password: String, completion: @escaping DatabaseResult)
  func login(login: String, password: String, completion: @escaping DatabaseResult)
  func logout()
  func saveFavouriteTrack(trackId: Int, completion: DatabaseResult)
  func getFavouriteTracks() -> [Int]
  
  var favouriteTracks: [Int]? { get set }
}

class FirebaseManager: DatabaseAccess
{
  let ref = Database.database().reference()
  
  var favouriteTracks: [Int]?
  
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
      try Auth.auth().signOut()
    } catch let err {
      // TODO: show error if logout fail
    }
  }
  
  func saveFavouriteTrack(trackId: Int, completion: DatabaseResult) {
    guard let user = self.currentUser else {
      completion(.failure(.database))
      return
    }
    
    let favRef = self.ref.child(FirebaseKeys.favouriteTracks)
    let userRef = favRef.child(user.providerID)
    userRef.setValue(trackId)
    completion(.success(user))
  }
  
  @discardableResult
  func getFavouriteTracks() -> [Int] {
    guard let user = currentUser else { return [] }
    let favRef = self.ref.child(FirebaseKeys.favouriteTracks)
    let userRef = favRef.child(user.providerID)
    userRef.observe(.value) { snapshot in
      let value = snapshot.value as? [String: Any]
    }
    
    return []
  }
}

