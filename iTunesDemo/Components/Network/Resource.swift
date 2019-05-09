//
//  Resource.swift
//  iTunesDemo
//
//  Created by Diana Alejandra Bonilla Granados on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

public typealias Headers = [String: String]

public struct Resource
{
  public let path: String
  public let method: Method
  
  public var description: String {
    return "Path:\(path)\nMethod:\(method.rawValue)\n"
  }
}

public enum Method: String
{
  case GET
  case POST
}

extension Resource
{
  public func toRequest(baseURL: URL) -> URLRequest {
    let finalURL = URL(string: "\(baseURL)\(path)")!
    var request = URLRequest(url: finalURL)
    request.httpMethod = method.rawValue
    return request
  }
}
