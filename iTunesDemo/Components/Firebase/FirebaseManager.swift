//
//  FirebaseManager.swift
//  iTunesDemo
//
//  Created by Anou on 07/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation
import Firebase

typealias FirebaseResult = (Result<User, Error?>) -> Void

class FirebaseManager
{
  static let shared = FirebaseManager()
  
  var currentUser: User?
  
  func createAccount(login: String, password: String, completion: @escaping FirebaseResult) {
    Auth.auth().createUser(withEmail: login, password: password) { [weak self] user, error in
      if error != nil {
        completion(.failure(.network))
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
  
  func login(login: String, password: String, completion: @escaping FirebaseResult) {
    Auth.auth().signIn(withEmail: login, password: password) { [weak self] user, error in
      if error != nil {
        completion(.failure(.network))
        return
      }
      
      self?.currentUser = user?.user
      
      if let usr = user {
        completion(.success(usr.user))
      } else {
        completion(.failure(.network))
      }
    }
  }
}
