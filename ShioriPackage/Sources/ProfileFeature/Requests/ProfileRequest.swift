//
//  ProfileRequest.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/24.
//

import Foundation
import Utility

struct ProfileRequest: ShioriRequestProtocol {
  typealias Response = Families
  
  var method: HTTPMethod = .get
  var path: Endpoint = .profile
  var headers: [String : String]? = nil
  var body: Data? = nil
}
