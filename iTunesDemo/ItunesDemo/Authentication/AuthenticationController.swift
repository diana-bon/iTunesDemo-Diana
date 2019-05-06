//
//  AuthenticationController.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 21/04/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation
import Firebase

class AuthenticationController
{
  var view: AuthenticationControllerOutput
  
  init(view: AuthenticationControllerOutput) {
    self.view = view
  }
}

extension AuthenticationController: AuthenticationControllerInput
{
  func login(login: String, password: String) {
    // TODO: login with firebase
    view.loginSuccess()
  }
}
