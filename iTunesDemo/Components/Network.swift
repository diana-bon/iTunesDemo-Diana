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
  func request(resource: Resource, completion: @escaping (Result<Data, Error>) -> Void)
}

final class Network
{
  private let session: URLSession
  private let baseURL: URL
  
  init(baseURL: URL, session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
    self.baseURL = baseURL
    self.session = session
  }
}

extension Network: Networkable
{
  func request(resource: Resource, completion: @escaping (Result<Data, Error>) -> Void) {
    let request = resource.toRequest(baseURL: baseURL)
    session.dataTask(with: request) { (data, response, error) in
      switch (data, error) {
      case(let data?, _):
        completion(Result<Data, Error>.success(data))
      case(_, let error):
        let failure = Result<Data, Error>.failure(.network(description: error?.localizedDescription ?? "Network Error"))
        completion(failure)
      }
    }.resume()
  }
}


