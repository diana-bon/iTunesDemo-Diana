//
//  AuthenticationFactory.swift
//  iTunesDemo
//
//  Created by Anou on 06/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

enum AuthenticationFactory
{
  static func createAuthModule(view: AuthenticationControllerOutput) -> AuthenticationControllerInput {
    let controller = AuthenticationController(view: view)
    return controller
  }
}
