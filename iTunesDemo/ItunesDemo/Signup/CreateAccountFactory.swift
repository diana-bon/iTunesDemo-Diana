//
//  CreateAccountFactory.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 06/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

enum CreateAccountFactory
{
  static func createAccountModule(view: CreateAccountControllerOutput) -> CreateAccountControllerInput {
    let controller = CreateAccountController(view: view)
    return controller
  }
}
