//
//  CreateAccountBoundaries.swift
//  iTunesDemo
//
//  Created by Anou on 06/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

protocol CreateAccountControllerInput
{
  func createAccount(login: String, password: String)
}

protocol CreateAccountControllerOutput
{
  func createAccountSuccess()
  func displayError(_ message: String)
}
