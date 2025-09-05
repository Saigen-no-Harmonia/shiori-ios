//
//  AccessRequest.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/24.
//

import Foundation
import Utility

struct AccessRequest: ShioriRequestProtocol {
  typealias Response = Access
  
  var method: HTTPMethod = .get
  var path: Endpoint = .access
  var headers: [String : String]? = nil
  var body: Data? = nil
  var queryItems: [URLQueryItem]? = nil
}
