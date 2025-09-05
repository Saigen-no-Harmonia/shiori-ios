//
//  GreetingRequest.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/24.
//

import Foundation
import Utility

struct GreetingRequest: ShioriRequestProtocol {
  typealias Response = GreetingResponse
  
  var method: HTTPMethod = .get
  var path: Endpoint = .greeting
  var headers: [String : String]? = nil
  var body: Data? = nil
  var queryItems: [URLQueryItem]? = nil
}
