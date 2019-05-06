//
//  CreateAccountController.swift
//  iTunesDemo
//
//  Created by Anou on 06/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

class CreateAccountController
{
  var view: CreateAccountControllerOutput
  
  init(view: CreateAccountControllerOutput) {
    self.view = view
  }
}

extension CreateAccountController: CreateAccountControllerInput
{
  func createAccount(login: String, password: String) {
    // TODO: Create account with firebase
    view.createAccountSuccess()
  }
}
