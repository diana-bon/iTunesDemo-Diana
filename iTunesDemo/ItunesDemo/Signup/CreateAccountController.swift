//
//  CreateAccountController.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 06/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation
import Firebase

class CreateAccountController: DatabaseInjector
{
  var view: CreateAccountControllerOutput
  
  init(view: CreateAccountControllerOutput) {
    self.view = view
  }
  
  enum ErrorMessage
  {
    static let createAccount = "The account couldn't be created."
  }
  
  private func handleError(_ error: Error?) {
    self.view.displayError(ErrorMessage.createAccount)
  }
  
  private func handleSuccess(user: User) {
    self.view.createAccountSuccess(email: user.email)
  }
}

extension CreateAccountController: CreateAccountControllerInput
{
  func createAccount(login: String, password: String) {
    // Create account with firebase
    database.createAccount(login: login, password: password) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .failure(let error):
        self.handleError(error)
      case .success(let user):
        self.handleSuccess(user: user)
      }
    }
  }
}
