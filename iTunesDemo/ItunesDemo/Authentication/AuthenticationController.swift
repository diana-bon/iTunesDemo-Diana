//
//  AuthenticationController.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 21/04/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

class AuthenticationController
{
  var view: AuthenticationControllerOutput
  var database: DatabaseAccess
  
  init(view: AuthenticationControllerOutput, database: DatabaseAccess) {
    self.view = view
    self.database = database
  }
  
  enum ErrorMessage
  {
    static let login = "The user couldn't log in with firebase."
  }
  
  private func handleError(_ error: Error?) {
    self.view.displayError(ErrorMessage.login)
  }
  
  private func handleSuccess() {
    database.getFavouriteTracks()
    self.view.loginSuccess()
  }
}

extension AuthenticationController: AuthenticationControllerInput
{
  func login(login: String, password: String) {
    database.login(login: login, password: password) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .failure(let error):
        self.handleError(error)
      case .success:
        self.handleSuccess()
      }
    }
  }
}
