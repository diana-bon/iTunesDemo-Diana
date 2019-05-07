//
//  Network.swift
//  iTunesDemo
//
//  Created by Anou on 04/05/2019.
//  Copyright © 2019 Diana Bonilla. All rights reserved.
//

import Foundation

protocol Networkable
{
  func request(resource: Resource, completion: @escaping (NetworkResult) -> Void)
}

typealias NetworkResult = Result<String, Error>

final class Network
{
  private let session: URLSession
  private let baseURL: URL
  
  enum ErrorType
  {
    static let `default` = "Error"
  }
  
  init(baseURL: URL, session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
    self.baseURL = baseURL
    self.session = session
  }
}

extension Network: Networkable
{
  func request(resource: Resource, completion: @escaping (NetworkResult) -> Void) {
    var request = resource.toRequest(baseURL: baseURL)
    print("Requesting: \(String(describing: request.url?.absoluteString ?? ""))")
    
    session.dataTask(with: request) { (data, response, error) in
      switch (data, error) {
      case(let data?, _):
        if let jsonStr = String(data: data, encoding: .utf8) {
          print("Response data: \(String(describing: jsonStr))")
          completion(.success(jsonStr))
        } else {
          completion(.failure(.parsing))
        }
      case(_, _):
          completion(.failure(.network))
      }
    }.resume()
  }
}


