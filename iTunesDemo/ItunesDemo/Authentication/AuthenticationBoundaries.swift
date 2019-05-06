//
//  AuthenticationBoundaries.swift
//  iTunesDemo
//
//  Created by Anou on 06/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

protocol AuthenticationControllerInput
{
  func login(login: String, password: String)
}

protocol AuthenticationControllerOutput
{
  func loginSuccess()
  func displayError(_ message: String)
}
