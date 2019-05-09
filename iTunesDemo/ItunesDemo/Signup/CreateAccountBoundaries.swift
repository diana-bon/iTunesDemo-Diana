//
//  CreateAccountBoundaries.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 06/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

protocol CreateAccountControllerInput
{
  func createAccount(login: String, password: String)
}

protocol CreateAccountControllerOutput
{
  func createAccountSuccess(email: String?)
  func displayError(_ message: String)
}
