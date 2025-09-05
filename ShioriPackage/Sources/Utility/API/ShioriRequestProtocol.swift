//
//  ShioriRequestProtocol.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/24.
//

import Foundation

public protocol ShioriRequestProtocol {
  associatedtype Response: Decodable

  var path: Endpoint { get set }
  var method: HTTPMethod { get set }
  var headers: [String: String]? { get set }
  var body: Data? { get set }
  var queryItems: [URLQueryItem]? { get set }
}
